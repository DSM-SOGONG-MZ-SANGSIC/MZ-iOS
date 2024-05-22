import UIKit
import RxFlow

class QuizFlow: Flow {
    var root: Presentable { presentable }
    private let presentable: QuizViewController
    private let container = AppDelegate.container

    init() {
        self.presentable = QuizViewController(viewModel: container.quizViewModel)
    }

    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? MZStep else { return .none }
        switch step {
        case .quizRequired(let category):
            return navigateToQuizScreen(category: category)
        default:
            return .none
        }
    }

    private func navigateToQuizScreen(category: String) -> FlowContributors {
        container.quizViewModel.category = category
        return .one(flowContributor: .contribute(
            withNextPresentable: presentable,
            withNextStepper: presentable.viewModel
        ))
    }
}
