import Foundation

struct AppDI {
    let loginViewModel: LoginViewModel
    let categoryViewModel: CategoryViewModel
    let problumViewModel: ProblumViewModel
    let friendRequestViewModel: FriendRequestViewModel
    let myFriendListViewModel: MyFriendListViewModel
    let savedProblumViewModel: SavedProblumViewModel
    let savedQuizDetailViewModel: SavedQuizDetailViewModel
}

extension AppDI {
    static func resolved() -> Self {

        let oauthService = OauthService()
        let quizService = QuizService()
        let friendService = FriendService()

        let loginViewModel = LoginViewModel(oauthService: oauthService)
        let categoryViewModel = CategoryViewModel()
        let problumViewModel = ProblumViewModel(quizService: quizService)
        let friendRequestViewModel = FriendRequestViewModel(friendService: friendService)
        let myFriendListViewModel = MyFriendListViewModel(friendService: friendService)
        let savedProblumViewModel = SavedProblumViewModel(quizService: quizService)
        let savedQuizDetailViewModel = SavedQuizDetailViewModel(quizService: quizService)

        return .init(
            loginViewModel: loginViewModel,
            categoryViewModel: categoryViewModel,
            problumViewModel: problumViewModel,
            friendRequestViewModel: friendRequestViewModel,
            myFriendListViewModel: myFriendListViewModel,
            savedProblumViewModel: savedProblumViewModel,
            savedQuizDetailViewModel: savedQuizDetailViewModel
        )
    }
}
