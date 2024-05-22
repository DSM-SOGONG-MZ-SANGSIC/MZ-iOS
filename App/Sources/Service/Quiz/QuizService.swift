import Foundation
import Moya
import RxMoya
import RxSwift
import RxCocoa

class QuizService {
    private let provider = MoyaProvider<QuizAPI>(plugins: [MoyaLoggingPlugin()])
    
    func fetchQuizList(_ category: String) -> Single<(QuizListDTO?, NetworkingResult)> {
        return provider.rx.request(.fetchQuizList(category))
            .filterSuccessfulStatusCodes()
            .map(QuizListDTO.self)
            .map { return ($0, .OK) }
            .catch { error in
                print(error)
                return .just((nil, .DEFAULT))
            }
    }
}
