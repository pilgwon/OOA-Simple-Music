//
//  LibraryMainViewController.swift
//  SimpleMusic
//
//  Created by PilGwonKim on 2020/04/04.
//  Copyright © 2020 OvertheOceanApps. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import MediaPlayer

class LibraryMainViewController: BaseViewController {
    private var albumList: [MPMediaItemCollection] = []
    
    private let albumCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private let cellIdentifier: String = "albumCellIdentifier"
    
    private let miniPlayerView: MiniPlayerView = MiniPlayerView()
    private var timer: Observable<NSInteger> = Observable<NSInteger>.interval(.seconds(1), scheduler: MainScheduler.instance)
    
    override func addSubviews() {
        super.addSubviews()
        
        view.addSubview(albumCollectionView)
        view.addSubview(miniPlayerView)
        
        albumCollectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
        
    override func layout() {
        super.layout()
        
        albumCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(80)
        }
        
        miniPlayerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(80)
        }
    }
        
    override func style() {
        super.style()
        
        navigationItem.title = "라이브러리"
        
        albumCollectionView.backgroundColor = UIColor.lightGray
    }
        
    override func behavior() {
        super.behavior()
        
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        
        miniPlayerView.updatePlayerState()
        
        timer
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.miniPlayerView.updatePlayerState()
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let albums = MPMediaQuery.albums().collections {
            albumList = albums
            albumCollectionView.reloadData()
        }
    }
}

extension LibraryMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AlbumCollectionViewCell
        cell.updateData(albumList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.size.width - 30) / 2
        return CGSize(width: width, height: width + 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: AlbumViewController = AlbumViewController()
        vc.album = albumList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
