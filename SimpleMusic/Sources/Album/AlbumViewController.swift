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
    private let musicPlayer: MPMusicPlayerController = MPMusicPlayerController.systemMusicPlayer
    
    var album: MPMediaItemCollection?

    override func addSubviews() {
        super.addSubviews()
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(albumInfoView)
        mainStackView.addArrangedSubview(albumActionView)
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
    }
        
    override func style() {
        super.style()
        
        mainStackView.alignment = .leading
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.distribution = .equalSpacing
        
        guard let album = album else { return }
        
        albumInfoView.updateInfo(album)
        
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
                    self.musicPlayer.shuffleMode = .off
                    self.musicPlayer.setQueue(with: album)
                    self.musicPlayer.nowPlayingItem = item
                    self.musicPlayer.play()
                }
                .disposed(by: disposeBag)
        }
    }
        
    override func behavior() {
        super.behavior()
        
        albumActionView.playButton.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self, let album = self.album else { return }
                self.musicPlayer.shuffleMode = .off
                self.musicPlayer.setQueue(with: album)
                self.musicPlayer.play()
            }
            .disposed(by: disposeBag)
        
        albumActionView.shuffleButton.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self, let album = self.album else { return }
                self.musicPlayer.shuffleMode = .songs
                self.musicPlayer.setQueue(with: album)
                self.musicPlayer.play()
            }
            .disposed(by: disposeBag)
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
