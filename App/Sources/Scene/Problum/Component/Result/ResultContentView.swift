import UIKit
import SnapKit
import Then

class ResultContentView: BaseView {
    private let resultStatusLable = UILabel().then {
        $0.font = .headerH2Medium
        $0.textColor = .black
        $0.textAlignment = .center
    }
    private let resultExplainLabel = UILabel().then {
        $0.font = .headerH3Medium
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    override func attribute() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }

    override func addview() {
        addSubViews(
            resultStatusLable,
            resultExplainLabel
        )
    }

    override func setLayout() {
        resultStatusLable.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        resultExplainLabel.snp.makeConstraints {
            $0.top.equalTo(resultStatusLable.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        self.snp.makeConstraints {
            $0.bottom.equalTo(resultExplainLabel).offset(30)
        }
    }
}

extension ResultContentView {
    func setContent(_ result: QuizResultEntity) {
        resultStatusLable.text = result.answer ? "정답입니다!" : "오답입니다!"
        resultExplainLabel.text = result.commentation
    }
}
