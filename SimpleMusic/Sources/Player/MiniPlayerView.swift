//
//  MiniPlayerView.swift
//  SimpleMusic
//
//  Created by PilGwonKim on 2020/04/05.
//  Copyright © 2020 OvertheOceanApps. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import MediaPlayer

class MiniPlayerView: BaseView {
    private let progressView: UIProgressView = UIProgressView()
    private let playbackButton: UIButton = UIButton()
    private let musicTitleLabel: UILabel = UILabel()
    private let artistLabel: UILabel = UILabel()
    private let artworkImageView: UIImageView = UIImageView()
    
    var nowPlayingItem: MPMediaItem?
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(progressView)
        addSubview(playbackButton)
        addSubview(musicTitleLabel)
        addSubview(artistLabel)
        addSubview(artworkImageView)
    }
        
    override func layout() {
        super.layout()
        
        progressView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(5)
        }
        
        playbackButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(10)
            $0.size.equalTo(40)
        }
        
        artworkImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(40)
        }
        
        musicTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalTo(playbackButton.snp.trailing).offset(10)
            $0.trailing.equalTo(artworkImageView.snp.leading).offset(-10)
            $0.height.equalTo(20)
        }
        
        artistLabel.snp.makeConstraints {
            $0.top.equalTo(musicTitleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(playbackButton.snp.trailing).offset(10)
            $0.trailing.equalTo(artworkImageView.snp.leading).offset(-10)
            $0.height.equalTo(15)
        }
    }
        
    override func style() {
        super.style()
        
        backgroundColor = UIColor.yellow
        
        progressView.tintColor = UIColor.purple
        progressView.progress = 0
        
        playbackButton.setImage(Asset.playbackStatePlay.image, for: .normal)
        
        musicTitleLabel.textAlignment = .center
        musicTitleLabel.textColor = UIColor.black
        musicTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        artistLabel.textAlignment = .center
        artistLabel.textColor = UIColor.black
        artistLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        artworkImageView.clipsToBounds = true
        artworkImageView.contentMode = .scaleAspectFill
        artworkImageView.layer.cornerRadius = 4
        artworkImageView.layer.masksToBounds = true
    }
        
    override func behavior() {
        super.behavior()
        
        playbackButton.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                
                let isPlaying: Bool = Environment.shared.musicPlayer.playbackState == .playing ? true : false
                if isPlaying {
                    Environment.shared.musicPlayer.stop()
                    self.playbackButton.setImage(Asset.playbackStatePlay.image, for: .normal)
                } else {
                    Environment.shared.musicPlayer.play()
                    self.playbackButton.setImage(Asset.playbackStatePause.image, for: .normal)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func updatePlayerState() {
        if nowPlayingItem != Environment.shared.musicPlayer.nowPlayingItem {
            nowPlayingItem = Environment.shared.musicPlayer.nowPlayingItem
            artworkImageView.image = nowPlayingItem?.artwork?.image(at: CGSize(width: 40, height: 40))
            musicTitleLabel.text = nowPlayingItem?.title ?? "-"
            artistLabel.text = nowPlayingItem?.artist ?? "-"
        }
        
        let isPlaying: Bool = Environment.shared.musicPlayer.playbackState == .playing ? true : false
        playbackButton.setImage(isPlaying ? Asset.playbackStatePause.image : Asset.playbackStatePlay.image, for: .normal)
        
        let duration: Float = Float(Environment.shared.musicPlayer.nowPlayingItem?.playbackDuration ?? 0)
        if duration != 0 {
            let progress: Float = Float(Environment.shared.musicPlayer.currentPlaybackTime) / duration
            progressView.progress = progress
        }
    }
}
