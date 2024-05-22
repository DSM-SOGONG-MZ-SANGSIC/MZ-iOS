import Foundation
import Moya

enum QuizAPI {
    case fetchQuizList(_ category: String)
}

extension QuizAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://prod-server.xquare.app/mz-sangsic")!
    }
    
    var path: String {
        switch self {
        case .fetchQuizList:
            return "/quiz"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchQuizList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchQuizList(let category):
            return .requestParameters(
                parameters: ["category": category],
                encoding: URLEncoding.queryString
            )
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchQuizList:
            return TokenStorage.shared.toHeader(.access)
        }
    }
    
    
}
