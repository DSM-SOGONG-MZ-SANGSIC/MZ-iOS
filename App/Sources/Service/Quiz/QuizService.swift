import Foundation
import Moya
import RxMoya
import RxSwift
import RxCocoa

class QuizService {
    private let provider = MoyaProvider<QuizAPI>(plugins: [MoyaLoggingPlugin()])
    
    func fetchQuizList(_ category: String) -> Single<QuizListEntity> {
        return provider.rx.request(.fetchQuizList(category))
            .map(QuizListDTO.self)
            .map { $0.toDomain() }
    }

    func fetchQuizQuestion(_ quizID: Int) -> Single<QuestionListEntity> {
        return provider.rx.request(.fetchQuizQuestion(quizID))
            .map(QuestionListDTO.self)
            .map { $0.toDomain() }
    }

    func postQuizResult(_ quizID: Int, pickID: Int) -> Single<QuizResultEntity> {
        return provider.rx.request(.postQuizResult(quizID, pickID: pickID))
            .map(QuizResultDTO.self)
            .map { $0.toDomain() }
    }

    func fetchFriendQuizResult(_ quizID: Int) -> Single<CorrectFriendsEntity> {
        return provider.rx.request(.fetchFriendQuizResult(quizID))
            .map(CorrectFriendsDTO.self)
            .map { $0.toDomain() }
    }

    func saveQuiz(_ quizID: Int) -> Completable {
        return provider.rx.request(.saveQuiz(quizID))
            .asCompletable()
    }
}
