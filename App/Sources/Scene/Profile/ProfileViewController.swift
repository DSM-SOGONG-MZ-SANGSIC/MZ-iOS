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
import Kingfisher
import PhotosUI
import SwiftUI

class ProfileViewController: BaseVC<ProfileViewModel> {
    private let newProfileImage = PublishRelay<UIImage>()
    
    private let titleLabel = UILabel().then {
        $0.text = "👋🏻 마이페이지"
        $0.font = UIFont.headerH1SemiBold
        $0.textColor = .black
    }
    private let profileView = ProfileView()
    private let dividerView = UIView().then {
        $0.backgroundColor = .gray200
    }
    private lazy var chartView = UIHostingController(rootView: ChartView())
    private let favoriteButton = UIButton(type: .system).then {
        $0.layer.borderColor = UIColor.gray900.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.setTitle("   관심 카테고리 등록", for: .normal)
        $0.setTitleColor(.gray900, for: .normal)
        $0.titleLabel?.font = .headerH3Medium
        $0.contentHorizontalAlignment = .left
        $0.showsMenuAsPrimaryAction = true
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
    
    override func attribute() {
        view.backgroundColor = .white
        setMenuButton()
    }
    
    override func addView() {
        addChild(chartView)
        view.addSubViews(
            titleLabel,
            profileView,
            dividerView,
            chartView.view,
            favoriteButton,
            savedButton
        )
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
        chartView.view.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(240)
        }
        favoriteButton.snp.makeConstraints {
            $0.top.equalTo(chartView.view.snp.bottom).offset(20).priority(.low)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
        savedButton.snp.makeConstraints {
            $0.top.equalTo(favoriteButton.snp.bottom).offset(20).priority(.low)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
    
    override func bind() {
        let input = ProfileViewModel.Input(
            viewDidAppear: viewDidAppearRelay.asObservable(),
            toSavedButtonTapped: savedButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input: input)
        
        output.isProfileLoaded
            .subscribe(onNext: { [self] in
                if $0 == true { profileView.profile = viewModel.profile }
            }).disposed(by: disposeBag)
        viewModel.isCalculated
            .subscribe(onNext: { [self] in
                if $0 == true {
                    chartView = UIHostingController(rootView: ChartView(
                        userName: viewModel.profile.name, stats: viewModel.chartData
                    ))
                    chartView.view.clipsToBounds = true
                    chartView.view.layer.cornerRadius = 8
                    chartView.view.layer.borderColor = UIColor.gray900.cgColor
                    chartView.view.layer.borderWidth = 1
                }
                view.setNeedsLayout()
            }).disposed(by: disposeBag)
        profileView.plusButton.rx.tap
            .subscribe(onNext: {
                var config = PHPickerConfiguration()
                config.selectionLimit = 1
                config.filter = .any(of: [.images, .livePhotos, .screenshots])
                let photoPickerVC = PHPickerViewController(configuration: config)
                photoPickerVC.delegate = self
                self.present(photoPickerVC, animated: true)
            }).disposed(by: disposeBag)
    }
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    func setMenuButton() {
        let menuButtonTapped = { (action: UIAction) in
            self.favoriteButton.setTitle("   관심 카테고리    ‣    \(action.title)", for: .normal)
            print(toCategoryType(action.title))
        }
        favoriteButton.menu = UIMenu(children: [
            UIAction(title: "어휘", handler: menuButtonTapped),
            UIAction(title: "수학", handler: menuButtonTapped),
            UIAction(title: "사회(정치/시사)", handler: menuButtonTapped),
            UIAction(title: "과학", handler: menuButtonTapped),
            UIAction(title: "역사(사건/인물)", handler: menuButtonTapped),
            UIAction(title: "도덕", handler: menuButtonTapped),
            UIAction(title: "유머(신조어/넌센스)", handler: menuButtonTapped),
            UIAction(title: "스포츠", handler: menuButtonTapped),
            UIAction(title: "기타", handler: menuButtonTapped),
        ])
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async { [self] in
                    profileView.imageView.image = image as? UIImage ?? .init()
                    newProfileImage.accept(image as? UIImage ?? .init())
                }
            }
        }
    }
}
