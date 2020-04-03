//
//  AlbumActionView.swift
//  SimpleMusic
//
//  Created by PilGwonKim on 2020/04/04.
//  Copyright © 2020 OvertheOceanApps. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import MediaPlayer

class AlbumActionView: BaseView {
    let playButton: UIButton = UIButton(type: .system)
    let shuffleButton: UIButton = UIButton(type: .system)

    override func addSubviews() {
        super.addSubviews()
        
        addSubview(playButton)
        addSubview(shuffleButton)
    }
        
    override func layout() {
        super.layout()
        
        playButton.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().dividedBy(2).offset(-15)
        }
        
        shuffleButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().dividedBy(2).offset(-15)
        }
    }
        
    override func style() {
        super.style()
        
        playButton.setTitle("순차 재생", for: .normal)
        playButton.setTitleColor(UIColor.white, for: .normal)
        playButton.backgroundColor = UIColor.purple.withAlphaComponent(0.7)
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        playButton.layer.cornerRadius = 8
        playButton.layer.masksToBounds = true
        
        shuffleButton.setTitle("랜덤 재생", for: .normal)
        shuffleButton.setTitleColor(UIColor.white, for: .normal)
        shuffleButton.backgroundColor = UIColor.purple.withAlphaComponent(0.7)
        shuffleButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        shuffleButton.layer.cornerRadius = 8
        shuffleButton.layer.masksToBounds = true
    }
}
