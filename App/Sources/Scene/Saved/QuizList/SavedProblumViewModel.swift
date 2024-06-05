import Foundation

import RxSwift
import RxCocoa
import RxFlow

class SavedProblumViewModel: ViewModelType, Stepper {
    var steps: PublishRelay<Step> = .init()
    var disposeBag: DisposeBag = .init()

    private var savedQuiz: [SavedQuizEntity] = []
    private let quizService: QuizService

    init(quizService: QuizService) {
        self.quizService = quizService
    }
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let selectedIndexpath: Observable<IndexPath>
    }

    struct Output {
        let savedQuizList: Signal<[SavedQuizEntity]>
    }

    func transform(input: Input) -> Output {
        let savedQuizList = PublishRelay<[SavedQuizEntity]>()
        input.viewWillAppear
            .flatMap {
                self.quizService.fetchSavedQuiz()
                    .catch {
                        print($0)
                        return .never()
                    }
            }
            .map { $0.savedQuiz }
            .do(onNext: { [weak self] in self?.savedQuiz = $0 })
            .bind(to: savedQuizList)
            .disposed(by: disposeBag )
    
        input.selectedIndexpath
            .map { MZStep.savedQuizDetailRequired(savedQuizData: self.savedQuiz[$0.item]) }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(savedQuizList: savedQuizList.asSignal())
    }
}
