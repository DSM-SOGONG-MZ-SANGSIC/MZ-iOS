import Foundation

import RxSwift
import RxCocoa

class LoginViewModel: ViewModelType {
    var disposeBag: DisposeBag = .init()

    struct Input {}
    struct Output {}

    func transform(input: Input) -> Output {
        return Output()
    }
}
