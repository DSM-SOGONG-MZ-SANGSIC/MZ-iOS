import Foundation
import RxFlow
import RxRelay
import RxSwift
import RxCocoa

class CategoryViewModel: ViewModelType, Stepper {
    let categories = BehaviorRelay<[CategoryType]>(value: [.VOCA, .MATH, .HISTORY, .SPORTS, .HUMOR, .SCIENCE, .SOCIETY, .MORALITY, .ETC])
    var disposeBag: DisposeBag = .init()
    var steps: PublishRelay<Step> = .init()

    struct Input {
        let index: Signal<IndexPath>
    }

    struct Output {
    }

    func transform(input: Input) -> Output {
        input.index.asObservable()
            .map { MZStep.quizRequired(category: self.categories.value[$0.row]) }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        return Output()
    }
}
