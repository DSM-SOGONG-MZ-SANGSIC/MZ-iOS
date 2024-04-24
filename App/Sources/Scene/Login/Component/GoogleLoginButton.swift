import UIKit

import SnapKit
import Then

class GoogleLoginButton: UIButton {
    private let logoImageView = UIImageView().then {
        $0.image = MZAPPAsset.googleLogo.image
        $0.isUserInteractionEnabled = false
    }

    init() {
        super.init(frame: .zero)
        setTitleColor(.black, for: .normal)
        setTitle("구글로 로그인하기", for: .normal)
        titleLabel?.font = .bodyB1SemiBold
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray400.cgColor
        layer.cornerRadius = 15
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.width.height.equalTo(38)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
        }
        self.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
}
