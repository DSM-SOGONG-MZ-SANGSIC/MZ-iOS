//
//  ProfileView.swift
//  MZ-APP
//
//  Created by 강인혜 on 6/5/24.
//  Copyright © 2024 com.mz. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit
import Then

class ProfileView: UIView {
    var profile: ProfileEntity = .empty {
        willSet {
            nameLabel.text = newValue.name
            emailLabel.text = newValue.email
            imageView.kf.setImage(with: URL(string: newValue.profileImage))
        }
    }
    let imageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 36
        $0.layer.borderColor = UIColor.gray900.cgColor
        $0.layer.borderWidth = 0.5
    }
    let plusButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.backgroundColor = .white
        $0.tintColor = .gray900
        $0.layer.borderColor = UIColor.gray900.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 12
    }
    private let nameLabel = UILabel().then {
        $0.font = .headerH2SemiBold
        $0.textColor = .gray900
        $0.textAlignment = .left
    }
    private let emailLabel = UILabel().then {
        $0.font = .bodyB1Light
        $0.textColor = .gray900
        $0.textAlignment = .left
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.gray900.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        
        addSubViews([
            imageView,
            plusButton,
            nameLabel,
            emailLabel
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(72)
            $0.verticalEdges.left.equalToSuperview().inset(20)
        }
        plusButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.bottom.equalTo(imageView.snp.bottom)
            $0.right.equalTo(imageView.snp.right).offset(2)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.equalTo(imageView.snp.right).offset(24)
            $0.right.equalToSuperview().inset(26)
        }
        emailLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(32)
            $0.left.equalTo(plusButton.snp.right).offset(22)
            $0.right.equalToSuperview().inset(26)
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
    }
}
