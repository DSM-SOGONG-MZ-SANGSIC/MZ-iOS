import Foundation
import RxRelay
import RxSwift

class CategoryViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    let categories: Observable<[Categories]> = Observable.just([.VOCA, .MATH, .HISTORY, .SPORTS, .HUMOR, .SCIENCE, .SOCIETY, .MORALITY, .ETC])

    struct Input {
    }

    struct Output {
    }

    func transform(input: Input) -> Output {
        return Output()
    }
}
