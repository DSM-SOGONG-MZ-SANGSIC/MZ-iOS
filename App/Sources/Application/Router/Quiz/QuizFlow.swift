import UIKit
import RxFlow

class QuizFlow: Flow {
    var root: Presentable { presentable }
    private let presentable: ProblumViewController
    private let container = AppDelegate.container

    init() {
        self.presentable = ProblumViewController(viewModel: container.problumViewModel)
        self.presentable.hidesBottomBarWhenPushed = true
    }

    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? MZStep else { return .none }
        switch step {
        case .quizRequired(let category):
            return navigateToQuizScreen(category: category)
        case .navigateToBack:
            return navigateToBack()
        default:
            return .none
        }
    }

    private func navigateToQuizScreen(category: CategoryType) -> FlowContributors {
        presentable.category = category
        return .one(flowContributor: .contribute(
            withNextPresentable: presentable,
            withNextStepper: presentable.viewModel
        ))
    }

    private func navigateToBack() -> FlowContributors {
        presentable.navigationController?.popViewController(animated: true)
        return .none
    }
}
