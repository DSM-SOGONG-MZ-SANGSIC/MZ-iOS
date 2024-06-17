import UIKit
import RxFlow

class FriendPercentageFlow: Flow {
    var root: Presentable { presentable }
    private let presentable: FriendPercentageViewController
    private let container = AppDelegate.container

    init() {
        self.presentable = FriendPercentageViewController(viewModel: container.friendPercentageViewModel)
        self.presentable.hidesBottomBarWhenPushed = true
    }

    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? MZStep else { return .none }
        switch step {
        case .friendPercentageRequired(let id):
            return navigateToMyFriendPercentageScreen(userId: id)
        default:
            return .none
        }
    }

    private func navigateToMyFriendPercentageScreen(userId: Int) -> FlowContributors {
        presentable.userId = userId
        
        return .one(flowContributor: .contribute(
            withNextPresentable: presentable,
            withNextStepper: presentable.viewModel
        ))
    }
}
