//
//  AlbumViewController.swift
//  SimpleMusic
//
//  Created by PilGwonKim on 2020/04/04.
//  Copyright © 2020 OvertheOceanApps. All rights reserved.
//

import UIKit
import SnapKit
import MediaPlayer

class AlbumViewController: BaseViewController {
    private let mainScrollView: UIScrollView = UIScrollView()
    private let mainStackView: UIStackView = UIStackView()
    private let albumInfoView: AlbumInfoView = AlbumInfoView()
    private let albumActionView: AlbumActionView = AlbumActionView()
    
    private let musicListView: UIView = UIView()
    
    var album: MPMediaItemCollection?

    override func addSubviews() {
        super.addSubviews()
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(albumInfoView)
        mainStackView.addArrangedSubview(albumActionView)
        mainStackView.addArrangedSubview(musicListView)
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
        
        musicListView.snp.makeConstraints {
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
            let itemView: UIView = generateMusicItemView(index: index, item: item)
            mainStackView.addArrangedSubview(itemView)
            itemView.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
            }
        }
    }
    
    func generateMusicItemView(index: Int, item: MPMediaItem) -> UIView {
        let itemView: UIView = UIView()
        
        let numberLabel: UILabel = UILabel()
        itemView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(20)
        }
        numberLabel.text = "\(index)"
        numberLabel.textAlignment = .right
        numberLabel.textColor = UIColor.lightGray
        numberLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        let titleLabel: UILabel = UILabel()
        itemView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(numberLabel.snp.trailing).offset(10)
            $0.top.trailing.equalToSuperview().inset(10)
        }
        titleLabel.text = item.title ?? "-"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        let artistLabel: UILabel = UILabel()
        itemView.addSubview(artistLabel)
        artistLabel.snp.makeConstraints {
            $0.leading.equalTo(numberLabel.snp.trailing).offset(10)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.trailing.bottom.equalToSuperview().inset(10)
        }
        artistLabel.text = item.artist ?? "-"
        artistLabel.textColor = UIColor.lightGray
        artistLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        return itemView
    }
        
    override func behavior() {
        super.behavior()
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
