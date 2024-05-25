import Foundation

struct AppDI {
    let loginViewModel: LoginViewModel
    let categoryViewModel: CategoryViewModel
    let problumViewModel: ProblumViewModel
}

extension AppDI {
    static func resolved() -> Self {

        let oauthService = OauthService()
        let quizService = QuizService()

        let loginViewModel = LoginViewModel(oauthService: oauthService)
        let categoryViewModel = CategoryViewModel()
        let problumViewModel = ProblumViewModel(quizService: quizService)

        return .init(
            loginViewModel: loginViewModel,
            categoryViewModel: categoryViewModel,
            problumViewModel: problumViewModel
        )
    }
}
