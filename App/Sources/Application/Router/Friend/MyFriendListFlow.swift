import UIKit
import RxFlow

class MyFriendListFlow: Flow {
    var root: Presentable { presentable }
    private let presentable: MyFriendListViewController
    private let container = AppDelegate.container

    init() {
        self.presentable = MyFriendListViewController(viewModel: container.myFriendListViewModel)
        self.presentable.hidesBottomBarWhenPushed = true
    }

    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? MZStep else { return .none }
        switch step {
        case .myFriendListRequired:
            return navigateToMyFriendListScreen()
        case .friendPercentageRequired(let id):
            return navigateToMyFriendPercentageScreen(userId: id)
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
    
    private func navigateToMyFriendPercentageScreen(userId: Int) -> FlowContributors {
        let friendPercentageFlow = FriendPercentageFlow()
        Flows.use(friendPercentageFlow, when: .created) { [weak self] root in
            self?.presentable.navigationController?.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: friendPercentageFlow,
            withNextStepper: OneStepper(withSingleStep: MZStep.friendPercentageRequired(userId: userId))
        ))
    }
}
