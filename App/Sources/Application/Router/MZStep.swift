import Foundation
import RxFlow

enum MZStep: Step {
    case tabBarRequired
    case homeRequired
    case categoryRequired
    case quizRequired(category: CategoryType)
    case friendRequired
    case profileRequired
    case loginRequired
    case navigateToBack
}
