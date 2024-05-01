import Foundation
import RxRelay
import RxSwift

class CategoryViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    var categories = BehaviorRelay<[String]>(value: ["어휘", "역사(인물)", "역사(사건)", "수학", "과학", "스포츠", "어휘", "역사(인물)", "역사(사건)", "수학", "과학", "스포츠"])

    struct Input {
    }

    struct Output {
    }

    func transform(input: Input) -> Output {
        return Output()
    }
}
