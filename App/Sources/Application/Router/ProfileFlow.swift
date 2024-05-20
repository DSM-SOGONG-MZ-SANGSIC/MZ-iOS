import UIKit
import RxFlow

class ProfileFlow: Flow {
    var root: Presentable { presentable }
    private let presentable = UINavigationController()
    private let container = AppDelegate.container

    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? MZStep else { return .none }
        switch step {
        case .profileRequired:
            return navigateToProfileScreen()
        default:
            return .none
        }
    }

    // TODO: - profileView 넣기
    private func navigateToProfileScreen() -> FlowContributors {
        let view = UIViewController()
        view.view.backgroundColor = .blue
        presentable.pushViewController(view, animated: false)
        return .none
    }
}
