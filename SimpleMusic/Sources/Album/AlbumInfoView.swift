//
//  AlbumInfoView.swift
//  SimpleMusic
//
//  Created by PilGwonKim on 2020/04/04.
//  Copyright © 2020 OvertheOceanApps. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import MediaPlayer

class AlbumInfoView: BaseView {
    private let albumArtworkImageView: UIImageView = UIImageView()
    private let albumTitleLabel: UILabel = UILabel()
    private let albumArtistLabel: UILabel = UILabel()
    private let albumInfoDivider: UIView = UIView()

    override func addSubviews() {
        super.addSubviews()
        
        addSubview(albumArtworkImageView)
        addSubview(albumTitleLabel)
        addSubview(albumArtistLabel)
        addSubview(albumInfoDivider)
    }
        
    override func layout() {
        super.layout()
        
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
    }
        
    override func style() {
        super.style()
        
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
    }
        
    override func behavior() {
        super.behavior()
    }
    
    func updateInfo(_ album: MPMediaItemCollection) {
        albumArtworkImageView.image = album.representativeItem?.artwork?.image(at: CGSize(width: 250, height: 250))
        albumTitleLabel.text = album.representativeItem?.albumTitle ?? "-"
        albumArtistLabel.text = album.representativeItem?.albumArtist ?? "다양한 아티스트"
    }
}
