import Foundation
import RxSwift
import RxCocoa
import RxFlow

class SavedQuizDetailViewModel: ViewModelType, Stepper {

    var steps: PublishRelay<Step> = .init()
    var disposeBag: DisposeBag = .init()
    private let quizService: QuizService

    init(quizService: QuizService) {
        self.quizService = quizService
    }

    struct Input {
        let pickID: Observable<Int>
    }
    struct Output {
        let pickList: Signal<QuestionListEntity>
    }

    func transform(input: Input) -> Output {
        let pickList = PublishRelay<QuestionListEntity>()

        input.pickID
            .flatMap {
                self.quizService.fetchQuizQuestion($0)
                    .catch {
                        print($0)
                        return .never()
                    }
            }
            .bind(to: pickList)
            .disposed(by: disposeBag)

        return Output(pickList: pickList.asSignal())
    }
}
