//
//  BaseView.swift
//  SimpleMusic
//
//  Created by PilGwonKim on 2020/04/04.
//  Copyright © 2020 OvertheOceanApps. All rights reserved.
//

import UIKit
import RxSwift

class BaseView: UIView {
    public let disposeBag: DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        addSubviews()
        layout()
        style()
        behavior()
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
