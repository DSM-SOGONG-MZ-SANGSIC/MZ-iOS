import Foundation
import RxFlow
import RxRelay
import RxSwift

class QuizViewModel: ViewModelType, Stepper {
    var steps: PublishRelay<Step> = .init()
    var disposeBag: DisposeBag = .init()
    var category = ""
    
    private let quizService: QuizService
    
    init(quizService: QuizService) {
        self.quizService = quizService
    }
    
    struct Input {
    }
    
    struct Output {
        var quizzes: PublishRelay<Quizzes>
    }
    
    func transform(input: Input) -> Output {
        let quizzes = PublishRelay<Quizzes>()
        
        Observable.just(category)
            .flatMap { [self] category in
                quizService.fetchQuizzes(category)
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .OK:
                    quizzes.accept(data!)
                default:
                    print(res)
                }
            }).disposed(by: disposeBag)
        return Output(quizzes: quizzes)
    }
}
