import Foundation

import Moya

class TokenManagerPlugin: PluginType {
    private let tokenStorage = TokenStorage.shared

    func didReceive(_ result: Result<Response, MoyaError>, target: any TargetType) {
        guard let response = try? result.get(),
              let decodeData = try? JSONDecoder().decode(OauthResponse.self, from: response.data)
        else { return }
        tokenStorage.accessToken = decodeData.accessToken
        print("didReceive")
    }
}
