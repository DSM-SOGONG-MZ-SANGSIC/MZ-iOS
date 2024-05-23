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
        case .myFriendListRequired:
            return navigateToMyFriendListScreen()
        default:
            return .none
        }
    }

    private func navigateToFriendScreen() -> FlowContributors {
        let view = FriendRequestViewController(viewModel: container.friendRequestViewModel)
        presentable.pushViewController(view, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: view,
            withNextStepper: view.viewModel
        ))
    }
    
    private func navigateToMyFriendListScreen() -> FlowContributors {
        let myFriendListFlow = MyFriendListFlow()
        
        Flows.use(myFriendListFlow, when: .created) { [weak self] root in
            self?.presentable.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: myFriendListFlow,
            withNextStepper: OneStepper(withSingleStep: MZStep.myFriendListRequired)
        ))
    }
}
