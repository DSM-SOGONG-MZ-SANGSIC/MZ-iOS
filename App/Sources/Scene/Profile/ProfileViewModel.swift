//
//  ProfileViewModel.swift
//  MZ-APP
//
//  Created by 강인혜 on 5/29/24.
//  Copyright © 2024 com.mz. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

class ProfileViewModel: ViewModelType, Stepper {
    var disposeBag = DisposeBag()
    var steps: PublishRelay<Step> = .init()
    
    var profile = ProfileEntity(
        id: 0,
        name: "홍길동",
        email: "gil-dong@dsm.hs.kr",
        profileImage: "",
        categories: []
    )
    var chartData: [ChartData] = []
    let isCalculated = BehaviorRelay<Bool>(value: false)
    
    private let profileService: ProfileService
    
    init(profileService: ProfileService) {
        self.profileService = profileService
    }
    
    struct Input {
        let viewDidAppear: Observable<Void>
        let toSavedButtonTapped: Signal<Void>
    }
    
    struct Output {
        let isProfileLoaded: BehaviorRelay<Bool>
    }
    
    func transform(input: Input) -> Output {
        let isProfileLoaded = BehaviorRelay<Bool>(value: false)
        
        input.viewDidAppear
            .flatMap { _ in
                self.profileService.fetchMyProfile()
            }
            .subscribe(
                with: self,
                onNext: { _, data in
                    self.profile = data
                    isProfileLoaded.accept(true)
                    
                    self.fetchPercentage(userId: data.id)
                }
            ).disposed(by: disposeBag)
        
        input.toSavedButtonTapped.asObservable()
            .map { MZStep.savedQuizRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        return Output(isProfileLoaded: isProfileLoaded)
    }
    
    func fetchPercentage(userId: Int) {
        Observable.just(())
            .flatMap { _ in
                self.profileService.fetchPercentage(userId: userId)
            }
            .subscribe(
                with: self,
                onNext: { [self] _, data in
                    chartData = []
                    
                    data.percentage.forEach {
                        chartData.append(
                            ChartData(
                                category: $0.category.categoryName,
                                percentage: Int(Double($0.correct) / Double($0.solved) * 100)
                            )
                        )
                    }
                    print(chartData)
                    self.isCalculated.accept(true)
                }
            ).disposed(by: disposeBag)
    }
}
