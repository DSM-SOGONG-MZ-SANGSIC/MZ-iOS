import Foundation
import RxFlow
import RxRelay
import RxSwift
import RxCocoa

class CategoryViewModel: ViewModelType, Stepper {
    let categories = BehaviorRelay<[Categories]>(value: [.VOCA, .MATH, .HISTORY, .SPORTS, .HUMOR, .SCIENCE, .SOCIETY, .MORALITY, .ETC])
    var disposeBag: DisposeBag = .init()
    var steps: PublishRelay<Step> = .init()

    struct Input {
        let index: Signal<IndexPath>
    }

    struct Output {
    }

    func transform(input: Input) -> Output {
        let quizzes = PublishRelay<Quizzes>()
        
        input.index.asObservable()
            .flatMap { index -> Single<Step> in
                Single.just(MZStep.quizRequired(category: self.categories.value[index.row].categoryName))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        return Output()
    }
}
