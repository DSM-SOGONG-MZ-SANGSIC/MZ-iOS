//
//  ViewModelType.swift
//  MZ-APP
//
//  Created by 조병진 on 4/22/24.
//  Copyright © 2024 com.mz. All rights reserved.
//

import Foundation

import RxSwift

protocol ViewModelType {
    var disposeBag: DisposeBag { get set }

    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
