import Foundation
import Moya
import RxMoya
import RxSwift
import RxCocoa

class QuizService {
    private let provider = MoyaProvider<QuizAPI>(plugins: [MoyaLoggingPlugin()])
    
    func fetchQuizzes(_ category: String) -> Single<(Quizzes?, NetworkingResult)> {
        return provider.rx.request(.fetchQuizzes(category))
            .filterSuccessfulStatusCodes()
            .map(Quizzes.self)
            .map { return ($0, .OK) }
            .catch { error in
                print(error)
                return .just((nil, .DEFAULT))
            }
    }
}
