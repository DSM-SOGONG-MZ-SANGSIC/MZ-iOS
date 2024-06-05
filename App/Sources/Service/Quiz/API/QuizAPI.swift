import Foundation
import Moya

enum QuizAPI {
    case fetchQuizList(_ category: String)
    case fetchQuizQuestion(_ quizID: Int)
    case postQuizResult(_ quizID: Int, pickID: Int)
    case fetchFriendQuizResult(_ quizID: Int)
    case saveQuiz(_ quizID: Int)
    case fetchSavedQuiz
}

extension QuizAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://prod-server.xquare.app/mz-sangsic")!
    }
    
    var path: String {
        switch self {
        case .fetchQuizList: return "/quiz"
        case let .fetchQuizQuestion(quizID): return "/quiz/pick/\(quizID)"
        case let .postQuizResult(quizID, _): return "/quiz/\(quizID)"
        case let .fetchFriendQuizResult(quizID): return "/quiz/friend/\(quizID)"
        case let .saveQuiz(quizID): return "/quiz/user/\(quizID)"
        case .fetchSavedQuiz: return "/quiz/saved"
        }
    }

    var validationType: ValidationType { .successCodes }
    
    var method: Moya.Method {
        switch self {
        case .fetchQuizList, .fetchQuizQuestion, .fetchFriendQuizResult, .fetchSavedQuiz:
            return .get
        case .postQuizResult, .saveQuiz:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchQuizList(let category):
            return .requestParameters(
                parameters: ["category": category],
                encoding: URLEncoding.queryString
            )
        case .postQuizResult(_, let pickID):
            return .requestParameters(
                parameters: [
                    "pick_id": "\(pickID)"
                ],
                encoding: JSONEncoding.default
            )
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? { TokenStorage.shared.toHeader(.access) }
}
