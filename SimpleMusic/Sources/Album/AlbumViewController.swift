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
    private let miniPlayerView: MiniPlayerView = MiniPlayerView()
    
    var album: MPMediaItemCollection?
    private var timer: Observable<NSInteger> = Observable<NSInteger>.interval(.seconds(1), scheduler: MainScheduler.instance)

    override func addSubviews() {
        super.addSubviews()
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(albumInfoView)
        mainStackView.addArrangedSubview(albumActionView)
        
        addItemRows()
        
        mainStackView.addArrangedSubview(bottomBlankView)
        
        view.addSubview(miniPlayerView)
    }
    
    func addItemRows() {
        guard let album = album else { return }
        
        for (index, item) in album.items.enumerated() {
            let itemRow: AlbumItemRow = AlbumItemRow()
            mainStackView.addArrangedSubview(itemRow)
            itemRow.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
            }
            itemRow.updateInfo(index: index + 1, item: item)
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
    }
        
    override func style() {
        super.style()
        
        mainScrollView.contentInsetAdjustmentBehavior = .never
        
        mainStackView.alignment = .leading
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.distribution = .equalSpacing
        
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
        
        miniPlayerView.updatePlayerState()
        
        timer
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.miniPlayerView.updatePlayerState()
            })
            .disposed(by: disposeBag)
    }
    
    func updateMusicQueue(_ album: MPMediaItemCollection, shuffleMode: MPMusicShuffleMode = .off, nowPlayingItem: MPMediaItem? = nil) {
        Environment.shared.musicPlayer.shuffleMode = shuffleMode
        Environment.shared.musicPlayer.setQueue(with: album)
        if let item = nowPlayingItem {
            Environment.shared.musicPlayer.nowPlayingItem = item
        }
        Environment.shared.musicPlayer.play()
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
