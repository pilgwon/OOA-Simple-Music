//
//  AlbumItemRow.swift
//  SimpleMusic
//
//  Created by PilGwonKim on 2020/04/04.
//  Copyright © 2020 OvertheOceanApps. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import MediaPlayer

class AlbumItemRow: BaseView {
    private let numberLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    private let artistLabel: UILabel = UILabel()
    private let dividerView: UIView = UIView()
    let button: UIButton = UIButton()

    override func addSubviews() {
        super.addSubviews()
        
        addSubview(numberLabel)
        addSubview(titleLabel)
        addSubview(artistLabel)
        addSubview(dividerView)
        addSubview(button)
    }
        
    override func layout() {
        super.layout()
        
        numberLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(numberLabel.snp.trailing).offset(10)
            $0.top.trailing.equalToSuperview().inset(10)
        }
        
        artistLabel.snp.makeConstraints {
            $0.leading.equalTo(numberLabel.snp.trailing).offset(10)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.trailing.bottom.equalToSuperview().inset(10)
        }
        
        dividerView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
        
    override func style() {
        super.style()

        numberLabel.textAlignment = .right
        numberLabel.textColor = UIColor.lightGray
        numberLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        artistLabel.numberOfLines = 0
        artistLabel.textColor = UIColor.lightGray
        artistLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        dividerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    
    func updateInfo(index: Int, item: MPMediaItem) {
        numberLabel.text = "\(index)"
        titleLabel.text = item.title ?? "-"
        artistLabel.text = item.artist ?? "-"
    }
}
