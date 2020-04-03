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
    
    private let albumInfoView: UIView = UIView()
    private let albumArtworkImageView: UIImageView = UIImageView()
    private let albumTitleLabel: UILabel = UILabel()
    private let albumArtistLabel: UILabel = UILabel()
    private let albumInfoDivider: UIView = UIView()
    
    private let albumActionView: UIView = UIView()
    private let actionPlayButton: UIButton = UIButton()
    private let actionShuffleButton: UIButton = UIButton()
    
    private let musicListView: UIView = UIView()
    
    var album: MPMediaItemCollection?

    override func addSubviews() {
        super.addSubviews()
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(albumInfoView)
        mainStackView.addArrangedSubview(albumActionView)
        mainStackView.addArrangedSubview(musicListView)
        
        albumInfoView.addSubview(albumArtworkImageView)
        albumInfoView.addSubview(albumTitleLabel)
        albumInfoView.addSubview(albumArtistLabel)
        albumInfoView.addSubview(albumInfoDivider)
        
        albumActionView.addSubview(actionPlayButton)
        albumActionView.addSubview(actionShuffleButton)
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
        
        albumArtworkImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(100)
        }
        
        albumTitleLabel.snp.makeConstraints {
            $0.top.equalTo(albumArtworkImageView.snp.top).offset(10)
            $0.leading.equalTo(albumArtworkImageView.snp.trailing).offset(10)
        }
        
        albumArtistLabel.snp.makeConstraints {
            $0.top.equalTo(albumTitleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(albumArtworkImageView.snp.trailing).offset(10)
        }
        
        albumInfoDivider.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        actionPlayButton.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().dividedBy(2).offset(-15)
        }
        
        actionShuffleButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().dividedBy(2).offset(-15)
        }
    }
        
    override func style() {
        super.style()
        
        mainStackView.alignment = .leading
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.distribution = .equalSpacing
        
        albumArtworkImageView.contentMode = .scaleAspectFill
        albumArtworkImageView.clipsToBounds = true
        albumArtworkImageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        albumArtworkImageView.layer.borderWidth = 1
        albumArtworkImageView.layer.cornerRadius = 4
        
        albumTitleLabel.numberOfLines = 0
        albumTitleLabel.textColor = UIColor.black
        albumTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        albumArtistLabel.numberOfLines = 0
        albumArtistLabel.textColor = UIColor.darkGray
        albumArtistLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        albumInfoDivider.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        actionPlayButton.setTitle("순차 재생", for: .normal)
        actionPlayButton.setTitleColor(UIColor.white, for: .normal)
        actionPlayButton.backgroundColor = UIColor.purple.withAlphaComponent(0.7)
        actionPlayButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        actionPlayButton.layer.cornerRadius = 8
        actionPlayButton.layer.masksToBounds = true
        
        actionShuffleButton.setTitle("랜덤 재생", for: .normal)
        actionShuffleButton.setTitleColor(UIColor.white, for: .normal)
        actionShuffleButton.backgroundColor = UIColor.purple.withAlphaComponent(0.7)
        actionShuffleButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        actionShuffleButton.layer.cornerRadius = 8
        actionShuffleButton.layer.masksToBounds = true
        
        guard let album = album else { return }
        
        albumArtworkImageView.image = album.representativeItem?.artwork?.image(at: CGSize(width: 250, height: 250))
        albumTitleLabel.text = album.representativeItem?.albumTitle ?? "-"
        albumArtistLabel.text = album.representativeItem?.albumArtist ?? "다양한 아티스트"
        
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
