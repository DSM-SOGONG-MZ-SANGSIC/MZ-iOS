import UIKit
import RxFlow

class SavedQuizFlow: Flow {
    var root: Presentable { presentable }
    private let presentable: SavedProblumViewController
    private let container = AppDelegate.container

    init() {
        self.presentable = SavedProblumViewController(viewModel: container.savedProblumViewModel)
        self.presentable.hidesBottomBarWhenPushed = true
    }

    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? MZStep else { return .none }
        switch step {
        case .savedQuizRequired:
            return navigateToSavedQuiz()
        case .savedQuizDetailRequired(let savedQuizData):
            return navigateToSavedQuizDetail(savedQuizData)
        default:
            return .none
        }
    }

    private func navigateToSavedQuiz() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: presentable,
            withNextStepper: presentable.viewModel
        ))
    }

    private func navigateToSavedQuizDetail(_ data: SavedQuizEntity) -> FlowContributors {
        let view = SavedQuizDetailViewController(viewModel: container.savedQuizDetailViewModel)
        view.savedQuizData = data
        presentable.navigationController?.pushViewController(view, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: view,
            withNextStepper: view.viewModel
        ))
    }
}
