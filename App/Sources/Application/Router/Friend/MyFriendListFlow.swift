import UIKit
import RxFlow

class MyFriendListFlow: Flow {
    var root: Presentable { presentable }
    private let presentable: MyFriendListViewController
    private let container = AppDelegate.container

    init() {
        self.presentable = MyFriendListViewController(viewModel: container.myFriendListViewModel)
    }

    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? MZStep else { return .none }
        switch step {
        case .myFriendListRequired:
            return navigateToMyFriendListScreen()
        default:
            return .none
        }
    }

    private func navigateToMyFriendListScreen() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: presentable,
            withNextStepper: presentable.viewModel
        ))
    }
}
