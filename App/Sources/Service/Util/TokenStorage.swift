import Foundation
import KeychainSwift

enum TokenType {
    case access, refresh, noToken

    var key: String {
        switch self {
        case .access: return "accessToken"
        case .refresh: return "refreshToken"
        case .noToken: return "noToken"
        }
    }
}

class TokenStorage {
    static let shared = TokenStorage()
    private let keyChain = KeychainSwift()

    private init() {}
    var accessToken: String? {
        get { keyChain.get(TokenType.access.key) }
        set {
            guard let newValue else { return }
            keyChain.set(newValue, forKey: TokenType.access.key)
        }
    }

    var refreshToken: String? {
        get { keyChain.get(TokenType.refresh.key) }
        set {
            guard let newValue else { return }
            keyChain.set(newValue, forKey: TokenType.refresh.key)
        }
    }
    
    func toHeader(_ tokenType: TokenType) -> [String: String] {
        guard let accessToken = self.accessToken else {
            return ["Content-type": "application/json"]
        }
        
        switch tokenType {
        case .access:
            return [
                "Content-type": "application/json",
                "Authorization": "Bearer " + accessToken
            ]
        default:
            return ["Content-type": "application/json"]
        }
    }

    func removeToken() {
        accessToken = nil
        refreshToken = nil
    }
}
