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
    }
    
    func behavior() {
    }
}
