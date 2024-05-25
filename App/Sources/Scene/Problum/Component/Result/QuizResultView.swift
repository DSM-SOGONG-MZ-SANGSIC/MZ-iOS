import UIKit
import SnapKit
import Then

class QuizResultView: BaseView {

    private let resultContentView = ResultContentView()
    private let friendResultView = FriendResultView()
    let nextQuizButton = UIButton(type: .system).then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .gray900
        $0.setTitle("다음문제", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .headerH2SemiBold
    }
    let backButton = UIButton(type: .system).then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .gray900
        $0.setTitle("돌아가기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .headerH2SemiBold
    }

    override func attribute() {
        backgroundColor = .white
    }

    override func addview() {
        addSubViews(
            resultContentView,
            friendResultView,
            nextQuizButton,
            backButton
        )
    }

    override func setLayout() {
        resultContentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        friendResultView.snp.makeConstraints {
            $0.top.equalTo(resultContentView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        nextQuizButton.snp.makeConstraints {
            $0.height.equalTo(58)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-5)
        }
        backButton.snp.makeConstraints {
            $0.height.equalTo(58)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
}

extension QuizResultView {
    func setQuizResult(_ result: (QuizResultEntity, Bool)) {
        resultContentView.setContent(result.0)
        nextQuizButton.isHidden = result.1
        backButton.isHidden = !result.1
        self.isHidden = false
    }
}
