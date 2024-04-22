import UIKit

import SnapKit
import Then

class LoginViewController: BaseVC<LoginViewModel> {
    private let headerLabel = UILabel().then {
        $0.text = "MZ의 토막 상식"
        $0.textColor = .black
        $0.font = .headerH1SemiBold
    }

    private let googleLoginButton = GoogleLoginButton()

    override func attrebute() {
        view.backgroundColor = .white
    }

    override func addView() {
        view.addSubViews(
            headerLabel,
            googleLoginButton
        )
    }

    override func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150)
            $0.leading.equalToSuperview().inset(30)
        }
        googleLoginButton.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(130)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }
}
