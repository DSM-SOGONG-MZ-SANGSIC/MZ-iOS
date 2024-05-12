//
//  CategoryViewController.swift
//  MZ-APP
//
//  Created by 강인혜 on 4/22/24.
//  Copyright © 2024 com.mz. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class CategoryViewController: BaseVC<CategoryViewModel> {
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    private let contentBackView = UIView().then {
        $0.backgroundColor = .white
    }
    private let titleLabel = UILabel().then {
        $0.text = "🧩 카테고리"
        $0.font = UIFont.headerH1SemiBold
        $0.textColor = .black
    }
    private lazy var categoryCollectionView = UICollectionView(
        frame: .zero, 
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 36
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
        flowLayout.itemSize = CGSize(width: 150, height: 150)
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.collectionViewLayout = flowLayout
    }
    
    override func attribute() {
        view.backgroundColor = .white
    }
    
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentBackView)
        [
            titleLabel,
            categoryCollectionView
        ].forEach { contentBackView.addSubview($0) }
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        contentBackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.equalTo(1000)
        }
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(20)
        }
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(56)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func bind() {
        viewModel.categories
            .bind(to: categoryCollectionView.rx.items(
                cellIdentifier: "CategoryCell",
                cellType: CategoryCell.self)
            ) { _, category, cell in
                cell.text = category.rawValue
            }
            .disposed(by: disposeBag)
    }
}
