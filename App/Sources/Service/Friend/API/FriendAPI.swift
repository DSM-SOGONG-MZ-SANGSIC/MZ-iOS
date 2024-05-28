import Foundation
import Moya

enum FriendAPI {
    case fetchUsersToRequest
    case sendFriendReqeust(_ id: Int)
    case fetchFriendRequests
    case acceptReqeust(_ id: Int)
    case denyReqeust(_ id: Int)
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
        case .acceptReqeust(let id):
            return "/friends/\(id)"
        case .denyReqeust(let id):
            return "/friends/\(id)"
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
        case .acceptReqeust:
            return .patch
        case .denyReqeust:
            return .delete
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
        case .fetchUsersToRequest, .sendFriendReqeust, .fetchFriendRequests, .fetchMyFriends, .acceptReqeust, .denyReqeust:
            return TokenStorage.shared.toHeader(.access)
        }
    }
    
    
}
