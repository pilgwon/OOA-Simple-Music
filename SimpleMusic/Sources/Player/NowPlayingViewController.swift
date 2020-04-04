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
    private let handleWrapperView: UIView = UIView()
    private let handleView: UIView = UIView()
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
        
        mainStackView.addArrangedSubview(generateSpacerView(20))
        mainStackView.addArrangedSubview(handleWrapperView)
        mainStackView.addArrangedSubview(generateSpacerView(20))
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
        
        handleWrapperView.addSubview(handleView)
        
        timeStackView.addArrangedSubview(playbackTimeLabel)
        timeStackView.addArrangedSubview(remainTimeLabel)
        
        controlStackView.addArrangedSubview(repeatButton)
        controlStackView.addArrangedSubview(rewindButton)
        controlStackView.addArrangedSubview(playbackButton)
        controlStackView.addArrangedSubview(fastForwardButton)
        controlStackView.addArrangedSubview(shuffleButton)
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
        
        handleWrapperView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        handleView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalToSuperview()
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
            $0.height.equalTo(40)
        }
        
        rewindButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        playbackButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        fastForwardButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        shuffleButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        volumeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
        
    override func style() {
        super.style()
        
        mainStackView.alignment = .leading
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.distribution = .equalSpacing
        
        handleView.backgroundColor = UIColor.black
        handleView.alpha = 0.3
        handleView.layer.cornerRadius = 5
        handleView.layer.masksToBounds = true
        
        artworkImageView.contentMode = .scaleAspectFill
        artworkImageView.clipsToBounds = true
        artworkImageView.layer.cornerRadius = 8
        artworkImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        artworkImageView.layer.borderWidth = 1
        artworkImageView.layer.masksToBounds = true
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        artistLabel.textColor = UIColor.black
        artistLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        
        progressView.progress = 0
        progressView.progressTintColor = UIColor.gray
        progressView.trackTintColor = UIColor.lightGray
        
        timeStackView.alignment = .top
        timeStackView.axis = .horizontal
        timeStackView.spacing = 0
        timeStackView.distribution = .fillEqually
        
        playbackTimeLabel.textColor = UIColor.black
        playbackTimeLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        playbackTimeLabel.textAlignment = .left
        
        remainTimeLabel.textColor = UIColor.black
        remainTimeLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        remainTimeLabel.textAlignment = .right
        
        controlStackView.alignment = .top
        controlStackView.axis = .horizontal
        controlStackView.spacing = 0
        controlStackView.distribution = .fillEqually
        
        rewindButton.setImage(Asset.nowPlayingRewind.image, for: .normal)
        
        fastForwardButton.setImage(Asset.nowPlayingFastForward.image, for: .normal)
        
        volumeView.showsRouteButton = false
    }
        
    override func behavior() {
        super.behavior()
        
        updatePlayerState()
        
        timer
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.updatePlayerState()
            })
            .disposed(by: disposeBag)
            
        playbackButton.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                if Environment.shared.musicPlayer.playbackState == .playing {
                    Environment.shared.musicPlayer.stop()
                } else {
                    Environment.shared.musicPlayer.play()
                }
                self.updatePlaybackButtonState()
            }
            .disposed(by: disposeBag)
        
        rewindButton.rx.tap
            .subscribe { _ in
                if Int(Environment.shared.musicPlayer.currentPlaybackTime) < 5 {
                    Environment.shared.musicPlayer.skipToPreviousItem()
                } else {
                    Environment.shared.musicPlayer.skipToBeginning()
                }
            }
            .disposed(by: disposeBag)
        
        fastForwardButton.rx.tap
            .subscribe { _ in
                Environment.shared.musicPlayer.skipToNextItem()
            }
            .disposed(by: disposeBag)
        
        shuffleButton.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                if Environment.shared.musicPlayer.shuffleMode == .off {
                    Environment.shared.musicPlayer.shuffleMode = .songs
                } else {
                    Environment.shared.musicPlayer.shuffleMode = .off
                }
                self.updateShuffleButtonState()
            }
            .disposed(by: disposeBag)
        
        repeatButton.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                switch Environment.shared.musicPlayer.repeatMode {
                case .all:
                    Environment.shared.musicPlayer.repeatMode = .one
                case .one:
                    Environment.shared.musicPlayer.repeatMode = .none
                default:
                    Environment.shared.musicPlayer.repeatMode = .all
                }
                self.updateRepeatButtonState()
            }
            .disposed(by: disposeBag)
    }
    
    func updatePlayerState() {
        artworkImageView.image = Environment.shared.musicPlayer.nowPlayingItem?.artwork?.image(at: CGSize(width: 400, height: 400))
        titleLabel.text = Environment.shared.musicPlayer.nowPlayingItem?.title ?? "-"
        artistLabel.text = Environment.shared.musicPlayer.nowPlayingItem?.artist ?? "-"
        
        let duration: Int = Int(Environment.shared.musicPlayer.nowPlayingItem?.playbackDuration ?? 0)
        let playbackTime: Int = Int(Environment.shared.musicPlayer.currentPlaybackTime)
        let remainTime: Int = duration - playbackTime
        progressView.progress = duration == 0 ? 0 : Float(playbackTime) / Float(duration)
        playbackTimeLabel.text = "\(playbackTime / 60):\(String(format: "%02d", playbackTime % 60))"
        remainTimeLabel.text = "-\(remainTime / 60):\(String(format: "%02d", remainTime % 60))"
        
        updatePlaybackButtonState()
        updateRepeatButtonState()
        updateShuffleButtonState()
    }
    
    func updatePlaybackButtonState() {
        playbackButton.setImage(Environment.shared.musicPlayer.playbackState == .playing ? Asset.nowPlayingPause.image : Asset.nowPlayingPlay.image, for: .normal)
    }
    
    func updateRepeatButtonState() {
        switch Environment.shared.musicPlayer.repeatMode {
        case .none:
            repeatButton.setImage(Asset.nowPlayingRepeatDisabled.image, for: .normal)
        case .all:
            repeatButton.setImage(Asset.nowPlayingRepeat.image, for: .normal)
        case .one:
            repeatButton.setImage(Asset.nowPlayingRepeatOne.image, for: .normal)
        default:
            repeatButton.setImage(Asset.nowPlayingRepeat.image, for: .normal)
        }
    }
    
    func updateShuffleButtonState() {
        switch Environment.shared.musicPlayer.shuffleMode {
        case .off:
            shuffleButton.setImage(Asset.nowPlayingShuffleDisabled.image, for: .normal)
        default:
            shuffleButton.setImage(Asset.nowPlayingShuffle.image, for: .normal)
        }
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
