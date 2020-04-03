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
    private let actionPlayButton: UIButton = UIButton()
    private let actionShuffleButton: UIButton = UIButton()

    override func addSubviews() {
        super.addSubviews()
        
        addSubview(actionPlayButton)
        addSubview(actionShuffleButton)
    }
        
    override func layout() {
        super.layout()
        
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
    }
        
    override func behavior() {
        super.behavior()
    }
}
