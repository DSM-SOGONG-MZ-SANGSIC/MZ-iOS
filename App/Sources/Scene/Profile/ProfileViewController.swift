//
//  ProfileViewController.swift
//  MZ-APP
//
//  Created by 강인혜 on 5/29/24.
//  Copyright © 2024 com.mz. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow

class ProfileViewController: BaseVC<ProfileViewModel> {
    private let titleLabel = UILabel().then {
        $0.text = "👋🏻 마이페이지"
        $0.font = UIFont.headerH1SemiBold
        $0.textColor = .black
    }
    
    override func addView() {
        view.addSubViews(
            titleLabel
        )
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
    }
}
