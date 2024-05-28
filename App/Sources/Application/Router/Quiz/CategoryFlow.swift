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
        case .quizRequired(let category):
            return navigateToQuizScreen(category: category)
        default:
            return .none
        }
    }

    private func navigateToCategoryScreen() -> FlowContributors {
        let view = CategoryViewController(viewModel: container.categoryViewModel)
        presentable.pushViewController(view, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: view,
            withNextStepper: view.viewModel
        ))
    }

    private func navigateToQuizScreen(category: CategoryType) -> FlowContributors {
        let quizFlow = QuizFlow()
        Flows.use(quizFlow, when: .created) { [weak self] root in
            self?.presentable.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: quizFlow,
            withNextStepper: OneStepper(withSingleStep: MZStep.quizRequired(category: category))
        ))
    }
}
