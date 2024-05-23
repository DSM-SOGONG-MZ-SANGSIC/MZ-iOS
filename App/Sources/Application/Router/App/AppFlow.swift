import UIKit
import RxFlow

class AppFlow: Flow {
    var root: Presentable { presentable }
    var presentable: UIWindow

    private let container = AppDelegate.container

    init(presentable: UIWindow) {
        self.presentable = presentable
    }

    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? MZStep else { return .none }
        switch step {
        case .tabBarRequired:
            return presentTabBar()
        case .loginRequired:
            return presentLogin()
        default:
            return .none
        }
    }

    private func presentLogin() -> FlowContributors {
        let login = LoginViewController(viewModel: container.loginViewModel)

        presentable.rootViewController = login
        presentable.makeKeyAndVisible()

        return .one(flowContributor: .contribute(
            withNextPresentable: login,
            withNextStepper: login.viewModel
        ))
    }

    private func presentTabBar() -> FlowContributors {
        let tabbarFlow = TabBarFlow()
        Flows.use(tabbarFlow, when: .created) { [unowned self] in
            presentable.rootViewController = $0
            presentable.makeKeyAndVisible()
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: tabbarFlow,
            withNextStepper: OneStepper(withSingleStep: MZStep.tabBarRequired)
        ))
    }
}
