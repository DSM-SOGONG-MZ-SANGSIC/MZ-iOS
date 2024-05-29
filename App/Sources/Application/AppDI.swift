import Foundation

struct AppDI {
    let loginViewModel: LoginViewModel
    let categoryViewModel: CategoryViewModel
    let problumViewModel: ProblumViewModel
    let friendRequestViewModel: FriendRequestViewModel
    let myFriendListViewModel: MyFriendListViewModel
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

        return .init(
            loginViewModel: loginViewModel,
            categoryViewModel: categoryViewModel,
            problumViewModel: problumViewModel,
            friendRequestViewModel: friendRequestViewModel,
            myFriendListViewModel: myFriendListViewModel
        )
    }
}
