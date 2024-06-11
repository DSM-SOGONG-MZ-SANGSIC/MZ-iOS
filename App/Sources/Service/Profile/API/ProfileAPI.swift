import Foundation
import Moya

enum ProfileAPI {
    case fetchPercentages(userId: Int)
}

extension ProfileAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://prod-server.xquare.app/mz-sangsic/quiz")!
    }
    
    var path: String {
        switch self {
        case .fetchPercentages(let userId):
            return "/percentage/\(userId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPercentages:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchPercentages:
            return TokenStorage.shared.toHeader(.access)
        }
    }
    
    
}
