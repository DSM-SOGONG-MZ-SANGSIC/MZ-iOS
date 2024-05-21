import Foundation
import RxFlow

enum MZStep: Step {
    case tabBarRequired
    case homeRequired
    case categoryRequired
    case quizRequired(category: String)
    case friendRequired
    case profileRequired
    case loginRequired
}
