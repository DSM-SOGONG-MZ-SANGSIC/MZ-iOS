import UIKit
import RxFlow

class TabBarFlow: Flow {
    var root: Presentable { presentable }
    private let container = AppDelegate.container

    let presentable: UITabBarController = {
        let controller = UITabBarController()
        controller.tabBar.backgroundColor = .white
        controller.tabBar.tintColor = .gray800
        return controller
    }()

    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? MZStep else { return .none }
        switch step {
        case .tabBarRequired:
            return makeTabBar()
        default:
            return .none
        }
    }

    private func makeTabBar() -> FlowContributors {
        let categoeyFlow = CategoryFlow()
        let friendFlow = FriendFlow()
        let profileFlow = ProfileFlow()

        Flows.use(categoeyFlow, friendFlow, profileFlow, when: .created) { [unowned self] root1, root2, root3 in
            root1.tabBarItem = .init(title: nil, image: UIImage(systemName: "list.bullet"), selectedImage: nil)
            root2.tabBarItem = .init(title: nil, image: UIImage(systemName: "person.2.fill"), selectedImage: nil)
            root3.tabBarItem = .init(title: nil, image: UIImage(systemName: "person.circle"), selectedImage: nil)

            presentable.viewControllers = [root1, root2, root3]
        }

        return .multiple(flowContributors: [
            .contribute(
                withNextPresentable: categoeyFlow,
                withNextStepper: OneStepper(withSingleStep: MZStep.categoryRequired)
            ),
            .contribute(
                withNextPresentable: friendFlow,
                withNextStepper: OneStepper(withSingleStep: MZStep.friendRequired)
            ),
            .contribute(
                withNextPresentable: profileFlow,
                withNextStepper: OneStepper(withSingleStep: MZStep.profileRequired)
            )
        ])
    }
}
