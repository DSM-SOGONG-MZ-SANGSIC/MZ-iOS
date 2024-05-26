import UIKit
import SnapKit
import Then

class QuestionButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        attribute()
        questionTitleLable.text = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let questionTitleLable = UILabel().then {
        $0.font = .headerH2SemiBold
        $0.textColor = .black
    }

    private func attribute() {
        addSubview(questionTitleLable)
        questionTitleLable.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(22)
        }
        self.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        backgroundColor = .gray50
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray400.cgColor
    }
}
