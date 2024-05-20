import Foundation
import Moya

enum OauthAPI {
    case googleOauth(token: String)
}

extension OauthAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://prod-server.xquare.app/mz-sangsic")!
    }

    var validationType: ValidationType { .successCodes }

    var path: String { "users/google/ios" }

    var method: Moya.Method { .post }

    var task: Moya.Task {
        switch self {
        case let .googleOauth(code):
            return .requestParameters(
                parameters: ["token": code],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String : String]? { ["Content-Type": "application/json"] }
}
