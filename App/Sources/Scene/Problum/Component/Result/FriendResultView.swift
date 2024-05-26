import UIKit
import SnapKit
import Then

class FriendResultView: BaseView {
    private let friendResultLabel = UILabel().then {
        $0.font = .headerH3Medium
        $0.textColor = .black
        $0.textAlignment = .center
    }

    override func attribute() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }

    override func addview() {
        addSubview(friendResultLabel)
    }

    override func setLayout() {
        friendResultLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        self.snp.makeConstraints {
            $0.height.equalTo(58)
        }
    }
}

extension FriendResultView {
    func setFriendResult(count: Int) {
        friendResultLabel.text = "\(count)명의 친구가 이 문제를 맞췄어요"
    }
}
