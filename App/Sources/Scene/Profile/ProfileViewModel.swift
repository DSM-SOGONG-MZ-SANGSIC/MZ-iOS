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
    
    struct Input {
        let toSavedButtonTapped: Signal<Void>
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        input.toSavedButtonTapped.asObservable()
            .map { MZStep.savedQuizRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        return Output()
    }
}
