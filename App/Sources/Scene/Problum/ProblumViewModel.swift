import Foundation
import RxCocoa
import RxSwift
import RxFlow

class ProblumViewModel: ViewModelType, Stepper {
    var steps: PublishRelay<Step> = .init()
    var disposeBag: DisposeBag = .init()

    private var quizList: [QuizEntity] = []
    private var quizNumber = -1

    private let quizService: QuizService
    
    init(quizService: QuizService) {
        self.quizService = quizService
    }
    
    struct Input {
        let fetchQuizList: Observable<CategoryType>
        let fetchQuestion: Observable<Void>
        let seletedQuestion: Observable<Int>
        let navigetToBack: Observable<Void>
        let saveQuiz: Observable<Void>
    }
    
    struct Output {
        let fetchQuizListSuccess: Signal<Void>
        let quizContent: Signal<(Int, QuizEntity, [QuestionEntity])>
        let quizResult: Signal<(QuizResultEntity, Bool)>
        let saveQuizSuccess: Signal<Void>
        let correntFriend: Signal<CorrectFriendsEntity>
    }
    
    func transform(input: Input) -> Output {
        let fetchQuizListSuccess = PublishRelay<Void>()
        let quizResult = PublishRelay<(QuizResultEntity, Bool)>()
        let quizContent = PublishRelay<(Int, QuizEntity, [QuestionEntity])>()
        let saveQuizSuccess = PublishRelay<Void>()
        let correntFriend = PublishRelay<CorrectFriendsEntity>()

        input.fetchQuestion
            .filter { !self.quizList.isEmpty }
            .map { [self] in
                quizNumber += 1
                return quizList[quizNumber].id
            }
            .flatMap {
                self.quizService.fetchQuizQuestion($0)
            }
            .map { [self] in (quizNumber + 1, quizList[quizNumber], $0.questions) }
            .bind(to: quizContent)
            .disposed(by: disposeBag)

        input.fetchQuizList
            .flatMap {
                self.quizService.fetchQuizList($0.rawValue)
            }
            .map { $0.quizList }
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.quizNumber = -1
                    owner.quizList = data
                    fetchQuizListSuccess.accept(())
                }
            )
            .disposed(by: disposeBag)

        input.seletedQuestion
            .flatMap { [self] in
                self.quizService.postQuizResult(
                    quizList[quizNumber].id,
                    pickID: $0
                )
                .catch {
                    print($0)
                    return .never()
                }
            }
            .map { ($0, self.quizNumber == self.quizList.count - 1) }
            .bind(to: quizResult)
            .disposed(by: disposeBag)

        input.seletedQuestion
            .flatMap { [self] _ in
                self.quizService.fetchFriendQuizResult(quizList[quizNumber].id)
                .catch {
                    print($0)
                    return .never()
                }
            }
            .bind(to: correntFriend)
            .disposed(by: disposeBag)
            

        input.navigetToBack
            .map { MZStep.navigateToBack }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.saveQuiz
            .flatMap { [self] _ -> Single<Void> in
                quizService.saveQuiz(quizList[quizNumber].id)
                    .andThen(.just(()))
            }
            .bind(to: saveQuizSuccess)
            .disposed(by: disposeBag)
            

        return Output(
            fetchQuizListSuccess: fetchQuizListSuccess.asSignal(),
            quizContent: quizContent.asSignal(),
            quizResult: quizResult.asSignal(),
            saveQuizSuccess: saveQuizSuccess.asSignal(),
            correntFriend: correntFriend.asSignal()
        )
    }
}
