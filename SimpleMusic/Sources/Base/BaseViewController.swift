//
//  BaseViewController.swift
//  SimpleMusic
//
//  Created by PilGwonKim on 2020/04/04.
//  Copyright © 2020 OvertheOceanApps. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class BaseViewController: UIViewController {
    var disposeBag: DisposeBag = DisposeBag()

    func setupView() {
        addSubviews()
        layout()
        style()
        behavior()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func addSubviews() {
    }
    
    func layout() {
    }
    
    func style() {
        view.backgroundColor = UIColor.white
    }
    
    func behavior() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeNavigationPurple()
    }
    
    func makeNavigationPurple() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.purple
        navigationController?.navigationBar.backgroundColor = UIColor.purple
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
