//
//  NowPlayingViewController.swift
//  SimpleMusic
//
//  Created by PilGwonKim on 2020/04/05.
//  Copyright © 2020 OvertheOceanApps. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import MediaPlayer

class NowPlayingViewController: BaseViewController {
    private let mainScrollView: UIScrollView = UIScrollView()
    private let mainStackView: UIStackView = UIStackView()
    private let artworkImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let artistLabel: UILabel = UILabel()
    private let progressView: UIProgressView = UIProgressView()
    private let timeStackView: UIStackView = UIStackView()
    private let playbackTimeLabel: UILabel = UILabel()
    private let remainTimeLabel: UILabel = UILabel()
    private let controlStackView: UIStackView = UIStackView()
    private let repeatButton: UIButton = UIButton()
    private let rewindButton: UIButton = UIButton()
    private let playbackButton: UIButton = UIButton()
    private let shuffleButton: UIButton = UIButton()
    private let fastForwardButton: UIButton = UIButton()
    private let volumeView: MPVolumeView = MPVolumeView()
    
    private var timer: Observable<NSInteger> = Observable<NSInteger>.interval(.seconds(1), scheduler: MainScheduler.instance)

    override func addSubviews() {
        super.addSubviews()
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(artworkImageView)
        mainStackView.addArrangedSubview(generateSpacerView(30))
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(artistLabel)
        mainStackView.addArrangedSubview(generateSpacerView(20))
        mainStackView.addArrangedSubview(progressView)
        mainStackView.addArrangedSubview(timeStackView)
        mainStackView.addArrangedSubview(generateSpacerView(30))
        mainStackView.addArrangedSubview(controlStackView)
        mainStackView.addArrangedSubview(generateSpacerView(30))
        mainStackView.addArrangedSubview(volumeView)
        
        timeStackView.addArrangedSubview(playbackTimeLabel)
        timeStackView.addArrangedSubview(remainTimeLabel)
        
        controlStackView.addArrangedSubview(repeatButton)
        controlStackView.addArrangedSubview(rewindButton)
        controlStackView.addArrangedSubview(playbackButton)
        controlStackView.addArrangedSubview(shuffleButton)
        controlStackView.addArrangedSubview(fastForwardButton)
    }
    
    func generateSpacerView(_ height: Float) -> UIView {
        let view: UIView = UIView()
        view.snp.makeConstraints {
            $0.height.equalTo(height)
        }
        return view
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
        
        artworkImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(artworkImageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(27)
        }
        
        artistLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(27)
        }
        
        progressView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(5)
        }
        
        timeStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        playbackTimeLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        remainTimeLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        controlStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        repeatButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        rewindButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        playbackButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        fastForwardButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        shuffleButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        volumeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
        
    override func style() {
        super.style()
        
        mainStackView.alignment = .leading
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.distribution = .equalSpacing
        
        artworkImageView.image = Asset.dummyArtwork.image
        artworkImageView.contentMode = .scaleAspectFill
        artworkImageView.clipsToBounds = true
        artworkImageView.layer.cornerRadius = 8
        artworkImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        artworkImageView.layer.borderWidth = 1
        artworkImageView.layer.masksToBounds = true
        
        titleLabel.text = "PEOPLE (Feat. Paloalto, The Quiett)"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        artistLabel.text = "CODE KUNST"
        artistLabel.textColor = UIColor.black
        artistLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        
        progressView.progress = 0
        progressView.progressTintColor = UIColor.gray
        progressView.trackTintColor = UIColor.lightGray
        
        timeStackView.alignment = .top
        timeStackView.axis = .horizontal
        timeStackView.spacing = 0
        timeStackView.distribution = .fillEqually
        
        playbackTimeLabel.text = "0:00"
        playbackTimeLabel.textColor = UIColor.black
        playbackTimeLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        playbackTimeLabel.textAlignment = .left
        
        remainTimeLabel.text = "-0:00"
        remainTimeLabel.textColor = UIColor.black
        remainTimeLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        remainTimeLabel.textAlignment = .right
        
        controlStackView.alignment = .top
        controlStackView.axis = .horizontal
        controlStackView.spacing = 0
        controlStackView.distribution = .fillEqually
        
        repeatButton.setImage(Asset.playbackStatePlay.image, for: .normal)
        
        rewindButton.setImage(Asset.playbackStatePlay.image, for: .normal)
        
        playbackButton.setImage(Asset.playbackStatePlay.image, for: .normal)
        
        fastForwardButton.setImage(Asset.playbackStatePlay.image, for: .normal)
        
        shuffleButton.setImage(Asset.playbackStatePlay.image, for: .normal)
    }
        
    override func behavior() {
        super.behavior()
        
        timer
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
            })
            .disposed(by: disposeBag)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

private let deviceNames: [String] = [
    "iPhone 11 Pro"
]

@available(iOS 13.0, *)
struct NowPlayingViewController_Preview: PreviewProvider {
    static var previews: some SwiftUI.View {
        ForEach(deviceNames, id: \.self) { deviceName in
            UIViewControllerPreview {
                NowPlayingViewController()
            }.previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
#endif
