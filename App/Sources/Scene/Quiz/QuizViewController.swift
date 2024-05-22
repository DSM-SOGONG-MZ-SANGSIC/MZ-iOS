import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxRelay

class QuizViewController: BaseVC<QuizViewModel> {
    private let tmpView = UIView().then {
        $0.backgroundColor = .red
    }
    
    override func addView() {
        view.addSubViews(
            tmpView
        )
    }

    override func setLayout() {
        tmpView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func bind() {
        let input = QuizViewModel.Input()
        let output = viewModel.transform(input: input)
    }
}
