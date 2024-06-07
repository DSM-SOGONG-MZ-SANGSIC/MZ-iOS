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
    private let profileView = ProfileView()
    private let dividerView = UIView().then {
        $0.backgroundColor = .gray200
    }
    private let favoriteButton = UIButton(type: .system).then {
        $0.layer.borderColor = UIColor.gray900.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.setTitle("   관심 카테고리 등록", for: .normal)
        $0.setTitleColor(.gray900, for: .normal)
        $0.titleLabel?.font = .headerH3Medium
        $0.contentHorizontalAlignment = .left
    }
    private let savedButton = UIButton(type: .system).then {
        $0.layer.borderColor = UIColor.gray900.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.setTitle("   저장한 문제", for: .normal)
        $0.setTitleColor(.gray900, for: .normal)
        $0.titleLabel?.font = .headerH3Medium
        $0.contentHorizontalAlignment = .left
    }
    private let withdrawalButton = UIButton(type: .system).then {
        $0.layer.borderColor = UIColor.gray900.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.setTitle("   회원 탈퇴", for: .normal)
        $0.setTitleColor(.gray900, for: .normal)
        $0.titleLabel?.font = .headerH3Medium
        $0.contentHorizontalAlignment = .left
    }
    
    override func attribute() {
        view.backgroundColor = .white
        profileView.name = "홍길동"
        profileView.email = "gil-dong@dsm.hs.kr"
    }
    
    override func addView() {
        view.addSubViews(
            titleLabel,
            profileView,
            dividerView,
            favoriteButton,
            savedButton,
            withdrawalButton
        )
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.left.equalToSuperview().inset(20)
        }
        profileView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(34)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        dividerView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        favoriteButton.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        savedButton.snp.makeConstraints {
            $0.top.equalTo(favoriteButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        withdrawalButton.snp.makeConstraints {
            $0.top.equalTo(savedButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
}
