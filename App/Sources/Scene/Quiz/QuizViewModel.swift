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
        var quizList: PublishRelay<QuizListDTO>
    }
    
    func transform(input: Input) -> Output {
        let quizList = PublishRelay<QuizListDTO>()
        
        Observable.just(category)
            .flatMap { [self] category in
                quizService.fetchQuizList(category)
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .OK:
                    quizList.accept(data!)
                default:
                    print(res)
                }
            }).disposed(by: disposeBag)
        return Output(quizList: quizList)
    }
}
