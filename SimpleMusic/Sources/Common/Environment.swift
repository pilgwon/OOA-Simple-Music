//
//  Environment.swift
//  SimpleMusic
//
//  Created by PilGwonKim on 2020/04/05.
//  Copyright © 2020 OvertheOceanApps. All rights reserved.
//

import MediaPlayer

class Environment {
    let musicPlayer: MPMusicPlayerController
    
    init(musicPlayer: MPMusicPlayerController) {
        self.musicPlayer = musicPlayer
    }
    
    static var shared: Environment = {
        return Environment(musicPlayer: .systemMusicPlayer)
    }()
}
