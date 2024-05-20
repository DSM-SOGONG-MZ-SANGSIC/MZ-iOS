import UIKit
import RxFlow

class FriendFlow: Flow {
    var root: Presentable { presentable }
    private let presentable = UINavigationController()
    private let container = AppDelegate.container

    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? MZStep else { return .none }
        switch step {
        case .friendRequired:
            return navigateToFriendScreen()
        default:
            return .none
        }
    }

    // TODO: - friendView 넣기
    private func navigateToFriendScreen() -> FlowContributors {
        let view = UIViewController()
        view.view.backgroundColor = .gray
        presentable.pushViewController(view, animated: false)
        return .none
    }
}
