import UIKit
import SnapKit
import Then
import RxSwift
import RxRelay
import RxCocoa

class QuestionSelectView: BaseView {

    let selectedPickID = PublishRelay<Int>()
    private let disposeBag: DisposeBag = .init()

    private let questionStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 18
    }

    override func addview() {
        addSubview(questionStack)
    }

    override func setLayout() {
        questionStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension QuestionSelectView {
    func setQuestionList(list: [QuestionEntity]) {
        let views = questionStack.arrangedSubviews
        views.forEach(questionStack.removeArrangedSubview(_:))
        views.forEach { $0.removeFromSuperview() }

        list.enumerated().forEach { quetion in
            let button = QuestionButton(title: "\(quetion.offset + 1). \(quetion.element.content)")

            button.rx.tap
                .map { quetion.element.pickID }
                .bind(to: selectedPickID)
                .disposed(by: disposeBag)

            questionStack.addArrangedSubview(button)
        }
    }
}
