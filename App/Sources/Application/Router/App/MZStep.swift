import Foundation
import RxFlow

enum MZStep: Step {
    case tabBarRequired
    case homeRequired
    case categoryRequired
    case quizRequired(category: CategoryType)
    case friendRequired
    case myFriendListRequired
    case friendPercentageRequired(userId: Int)
    case profileRequired
    case loginRequired
    case savedQuizRequired
    case savedQuizDetailRequired(savedQuizData: SavedQuizEntity)
    case navigateToBack
}
