import Foundation
import Moya

enum ProfileAPI {
    case fetchMyProfile
    case fetchPercentages(userId: Int)
}

extension ProfileAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://prod-server.xquare.app/mz-sangsic")!
    }
    
    var path: String {
        switch self {
        case .fetchMyProfile:
            return "/users/mypage"
        case .fetchPercentages(let userId):
            return "/quiz/percentage/\(userId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMyProfile, .fetchPercentages:
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
        case .fetchMyProfile, .fetchPercentages:
            return TokenStorage.shared.toHeader(.access)
        }
    }
    
    
}
