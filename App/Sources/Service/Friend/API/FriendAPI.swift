import Foundation
import Moya

enum FriendAPI {
    case fetchUsersToRequest
    case sendFriendReqeust(_ id: Int)
    case fetchFriendRequests
    case fetchMyFriends
}

extension FriendAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://prod-server.xquare.app/mz-sangsic")!
    }
    
    var path: String {
        switch self {
        case .fetchUsersToRequest:
            return "/users"
        case .sendFriendReqeust(let id):
            return "/friends/\(id)"
        case .fetchFriendRequests:
            return "/friends/applied"
        case .fetchMyFriends:
            return "/friends"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUsersToRequest, .fetchFriendRequests, .fetchMyFriends:
            return .get
        case .sendFriendReqeust:
            return .post
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
        case .fetchUsersToRequest, .sendFriendReqeust, .fetchFriendRequests, .fetchMyFriends:
            return TokenStorage.shared.toHeader(.access)
        }
    }
    
    
}
