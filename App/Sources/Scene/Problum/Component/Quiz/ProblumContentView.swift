import UIKit
import SnapKit
import Then

class ProblumContentView: BaseView {
    private let quizNumberLabel = UILabel().then {
        $0.font = .headerH2Medium
        $0.textColor = .black
        $0.textAlignment = .center
    }
    private let contentLabel = UILabel().then {
        $0.font = .headerH2Medium
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    override func attribute() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray900.cgColor
    }

    override func addview() {
        addSubViews(
            quizNumberLabel,
            contentLabel
        )
    }

    override func setLayout() {
        quizNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview().inset(34)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(quizNumberLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(34)
        }
        self.snp.makeConstraints {
            $0.bottom.equalTo(contentLabel).offset(50)
        }
    }
}

extension ProblumContentView {
    func setProblumContent(quizNum: Int, content: String) {
        contentLabel.text = content
        quizNumberLabel.text = "Q\(quizNum)."
    }
}
