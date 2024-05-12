//
//  CategoryCell.swift
//  MZ-APP
//
//  Created by 강인혜 on 4/22/24.
//  Copyright © 2024 com.mz. All rights reserved.
//

import UIKit
import SnapKit
import Then

class CategoryCell: UICollectionViewCell {
    public var text: String {
        get { textLabel.text ?? "" }
        set { textLabel.text = newValue }
    }
    
    private let textLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.font = UIFont.headerH3SemiBold
    }
    private let circleImageView = UIImageView().then {
        $0.image = UIImage(named: "mosaic")
        $0.contentMode = .scaleAspectFit
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
        self.layer.borderColor = UIColor.gray700.cgColor
        self.layer.borderWidth = 1.5
        self.layer.shadowPath = UIBezierPath(
            roundedRect: self.bounds,
            cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.15
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        
        [
            textLabel,
            circleImageView
        ].forEach { self.addSubview($0) }
    
        setUpView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        textLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(20)
        }
        circleImageView.snp.makeConstraints {
            $0.right.bottom.equalToSuperview().inset(15)
            $0.width.height.equalTo(50)
        }
    }
}
