//
//  AlbumViewController.swift
//  SimpleMusic
//
//  Created by PilGwonKim on 2020/04/04.
//  Copyright © 2020 OvertheOceanApps. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import MediaPlayer

class AlbumViewController: BaseViewController {
    private let mainScrollView: UIScrollView = UIScrollView()
    private let mainStackView: UIStackView = UIStackView()
    private let albumInfoView: AlbumInfoView = AlbumInfoView()
    private let albumActionView: AlbumActionView = AlbumActionView()
    private let bottomBlankView: UIView = UIView()
    private let musicPlayer: MPMusicPlayerController = MPMusicPlayerController.systemMusicPlayer
    
    private let miniPlayerView: UIView = UIView()
    private let playerProgressView: UIProgressView = UIProgressView()
    private let playerPlaybackStateButton: UIButton = UIButton()
    private let playerAlbumTitleLabel: UILabel = UILabel()
    private let playerAlbumArtistLabel: UILabel = UILabel()
    private let playerAlbumArtworkImageView: UIImageView = UIImageView()
    
    var album: MPMediaItemCollection?

    override func addSubviews() {
        super.addSubviews()
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(albumInfoView)
        mainStackView.addArrangedSubview(albumActionView)
        
        addItemRows()
        
        mainStackView.addArrangedSubview(bottomBlankView)
        
        view.addSubview(miniPlayerView)
        miniPlayerView.addSubview(playerProgressView)
        miniPlayerView.addSubview(playerPlaybackStateButton)
        miniPlayerView.addSubview(playerAlbumTitleLabel)
        miniPlayerView.addSubview(playerAlbumArtistLabel)
        miniPlayerView.addSubview(playerAlbumArtworkImageView)
    }
    
    func addItemRows() {
        guard let album = album else { return }
        
        for (index, item) in album.items.enumerated() {
            let itemRow: AlbumItemRow = AlbumItemRow()
            mainStackView.addArrangedSubview(itemRow)
            itemRow.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
            }
            itemRow.updateInfo(index: index, item: item)
            itemRow.button.rx.tap
                .subscribe { [weak self] _ in
                    guard let self = self else { return }
                    self.updateMusicQueue(album, shuffleMode: .off, nowPlayingItem: item)
                }
                .disposed(by: disposeBag)
        }
    }
        
    override func layout() {
        super.layout()
        
        mainScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        albumInfoView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        albumActionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        bottomBlankView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        miniPlayerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        playerProgressView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(5)
        }
        
        playerPlaybackStateButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(10)
            $0.size.equalTo(40)
        }
        
        playerAlbumArtworkImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(40)
        }
        
        playerAlbumTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalTo(playerPlaybackStateButton.snp.trailing).offset(10)
            $0.trailing.equalTo(playerAlbumArtworkImageView.snp.leading).offset(-10)
            $0.height.equalTo(20)
        }
        
        playerAlbumArtistLabel.snp.makeConstraints {
            $0.top.equalTo(playerAlbumTitleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(playerPlaybackStateButton.snp.trailing).offset(10)
            $0.trailing.equalTo(playerAlbumArtworkImageView.snp.leading).offset(-10)
            $0.height.equalTo(15)
        }
    }
        
    override func style() {
        super.style()
        
        mainScrollView.contentInsetAdjustmentBehavior = .never
        
        mainStackView.alignment = .leading
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.distribution = .equalSpacing
        
        miniPlayerView.backgroundColor = UIColor.yellow
        
        playerProgressView.tintColor = UIColor.purple
        playerProgressView.progress = 0
        
        playerPlaybackStateButton.setImage(Asset.playbackStatePlay.image, for: .normal)
        
        playerAlbumTitleLabel.text = "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum"
        playerAlbumTitleLabel.textAlignment = .center
        playerAlbumTitleLabel.textColor = UIColor.black
        playerAlbumTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        playerAlbumArtistLabel.text = "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum"
        playerAlbumArtistLabel.textAlignment = .center
        playerAlbumArtistLabel.textColor = UIColor.black
        playerAlbumArtistLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        playerAlbumArtworkImageView.clipsToBounds = true
        playerAlbumArtworkImageView.contentMode = .scaleAspectFill
        
        guard let album = album else { return }
        albumInfoView.updateInfo(album)
    }
        
    override func behavior() {
        super.behavior()
        
        albumActionView.playButton.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self, let album = self.album else { return }
                self.updateMusicQueue(album, shuffleMode: .off)
            }
            .disposed(by: disposeBag)
        
        albumActionView.shuffleButton.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self, let album = self.album else { return }
                self.updateMusicQueue(album, shuffleMode: .songs)
            }
            .disposed(by: disposeBag)
    }
    
    func updateMusicQueue(_ album: MPMediaItemCollection, shuffleMode: MPMusicShuffleMode = .off, nowPlayingItem: MPMediaItem? = nil) {
        musicPlayer.shuffleMode = shuffleMode
        musicPlayer.setQueue(with: album)
        if let item = nowPlayingItem {
            musicPlayer.nowPlayingItem = item
        }
        musicPlayer.play()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

private let deviceNames: [String] = [
    "iPhone 11 Pro"
]

@available(iOS 13.0, *)
struct AlbumViewController_Preview: PreviewProvider {
    static var previews: some SwiftUI.View {
        ForEach(deviceNames, id: \.self) { deviceName in
            UIViewControllerPreview {
                BaseNavigationController(rootViewController: AlbumViewController())
            }.previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
#endif
