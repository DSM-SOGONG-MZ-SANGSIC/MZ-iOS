import Foundation

struct AppDI {
    let loginViewModel: LoginViewModel
}

extension AppDI {
    static func resolved() -> Self {

        let oauthService = OauthService()

        let loginViewModel = LoginViewModel(oauthService: oauthService)

        return .init(loginViewModel: loginViewModel)
    }
}
