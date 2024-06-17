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
        case .savedQuizRequired:
            return navigateToSavedQuizScreen()
        default:
            return .none
        }
    }

    private func navigateToProfileScreen() -> FlowContributors {
        let view = ProfileViewController(viewModel: container.profileViewModel)
        presentable.pushViewController(view, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: view, withNextStepper: view.viewModel))
    }
    
    private func navigateToSavedQuizScreen() -> FlowContributors {
        let savedQuizFlow = SavedQuizFlow()
        
        Flows.use(savedQuizFlow, when: .created) { [weak self] root in
            self?.presentable.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: savedQuizFlow,
            withNextStepper: OneStepper(withSingleStep: MZStep.savedQuizRequired)
        ))
    }
}
