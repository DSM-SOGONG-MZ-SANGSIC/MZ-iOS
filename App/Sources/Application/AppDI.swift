import Foundation

struct AppDI {
    let loginViewModel: LoginViewModel
    let categoryViewModel: CategoryViewModel
    let problumViewModel: ProblumViewModel
    let friendRequestViewModel: FriendRequestViewModel
    let myFriendListViewModel: MyFriendListViewModel
    let friendPercentageViewModel: FriendPercentageViewModel
    let savedProblumViewModel: SavedProblumViewModel
    let savedQuizDetailViewModel: SavedQuizDetailViewModel
    let profileViewModel: ProfileViewModel
}

extension AppDI {
    static func resolved() -> Self {

        let oauthService = OauthService()
        let quizService = QuizService()
        let friendService = FriendService()
        let profileService = ProfileService()

        let loginViewModel = LoginViewModel(oauthService: oauthService)
        let categoryViewModel = CategoryViewModel()
        let problumViewModel = ProblumViewModel(quizService: quizService)
        let friendRequestViewModel = FriendRequestViewModel(friendService: friendService)
        let myFriendListViewModel = MyFriendListViewModel(friendService: friendService)
        let friendPercentageViewModel = FriendPercentageViewModel(profileService: profileService)
        let savedProblumViewModel = SavedProblumViewModel(quizService: quizService)
        let savedQuizDetailViewModel = SavedQuizDetailViewModel(quizService: quizService)
        let profileViewModel = ProfileViewModel(profileService: profileService)

        return .init(
            loginViewModel: loginViewModel,
            categoryViewModel: categoryViewModel,
            problumViewModel: problumViewModel,
            friendRequestViewModel: friendRequestViewModel,
            myFriendListViewModel: myFriendListViewModel,
            friendPercentageViewModel: friendPercentageViewModel,
            savedProblumViewModel: savedProblumViewModel,
            savedQuizDetailViewModel: savedQuizDetailViewModel,
            profileViewModel: profileViewModel
        )
    }
}
