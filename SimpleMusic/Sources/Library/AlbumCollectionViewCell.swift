//
//  AlbumCollectionViewCell.swift
//  SimpleMusic
//
//  Created by PilGwonKim on 2020/04/04.
//  Copyright © 2020 OvertheOceanApps. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import MediaPlayer

class AlbumCollectionViewCell: BaseCollectionViewCell {
    private let artworkImageView: UIImageView = UIImageView()
    private let albumNameLabel: UILabel = UILabel()
    private let artistNameLabel: UILabel = UILabel()
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(artworkImageView)
        addSubview(albumNameLabel)
        addSubview(artistNameLabel)
    }
        
    override func layout() {
        super.layout()
        
        artworkImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(artworkImageView.snp.width)
        }
        
        albumNameLabel.snp.makeConstraints {
            $0.top.equalTo(artworkImageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(20)
        }
        
        artistNameLabel.snp.makeConstraints {
            $0.top.equalTo(albumNameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(15)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
        
    override func style() {
        super.style()
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 4
        layer.masksToBounds = true
        
        artworkImageView.contentMode = .scaleAspectFill
        artworkImageView.clipsToBounds = true
        
        albumNameLabel.textColor = UIColor.black
        albumNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        artistNameLabel.textColor = UIColor.darkGray
        artistNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
    func updateData(_ collection: MPMediaItemCollection) {
        artworkImageView.image = collection.representativeItem?.artwork?.image(at: CGSize(width: 250, height: 250))
        albumNameLabel.text = collection.representativeItem?.albumTitle ?? "-"
        artistNameLabel.text = collection.representativeItem?.albumArtist ?? "다양한 아티스트"
    }
}
