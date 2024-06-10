import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SavedQuizDetailViewController: BaseVC<SavedQuizDetailViewModel> {

    private let fetchPickRelay = PublishRelay<Int>()
    var savedQuizData: SavedQuizEntity? = nil

    private let answerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 18
    }

    private let problumContentView = ProblumContentView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let data = savedQuizData else { return }
        fetchPickRelay.accept(data.id)
    }

    override func attribute() {
        view.backgroundColor = .white
        guard let data = savedQuizData else { return }
        problumContentView.setProblumContent(quizNum: 1, content: data.content)
    }

    override func addView() {
        view.addSubViews(
            answerStackView,
            problumContentView
        )
    }

    override func setLayout() {
        problumContentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        answerStackView.snp.makeConstraints {
            $0.top.equalTo(problumContentView.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
    }

    override func bind() {
        let input = SavedQuizDetailViewModel.Input(pickID: fetchPickRelay.asObservable())
        let output = viewModel.transform(input: input)

        output.pickList.asObservable()
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                let views = answerStackView.arrangedSubviews
                views.forEach(answerStackView.removeArrangedSubview(_:))
                views.forEach { $0.removeFromSuperview() }

                data.questions.enumerated().forEach {
                    let quizCell = QuestionButton(
                        title: "\($0.offset + 1). \($0.element.content)",
                        isAnswer: $0.element.pickID == self.savedQuizData?.answer ?? 0
                    )
                    self.answerStackView.addArrangedSubview(quizCell)
                }
            })
            .disposed(by: disposeBag)
    }
}
