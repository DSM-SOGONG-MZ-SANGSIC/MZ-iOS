import UIKit
import RxFlow

class CategoryFlow: Flow {
    var root: Presentable { presentable }
    private let presentable = UINavigationController()
    private let container = AppDelegate.container

    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? MZStep else { return .none }
        switch step {
        case .categoryRequired:
            return navigateToCategoryScreen()
        default:
            return .none
        }
    }

    // TODO: - categoryView 넣기
    private func navigateToCategoryScreen() -> FlowContributors {
        let view = UIViewController()
        view.view.backgroundColor = .white
        presentable.pushViewController(view, animated: false)
        return .none
    }
}
