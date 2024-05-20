import UIKit

import RxSwift
import RxCocoa
import GoogleSignIn
import SnapKit
import Then

class LoginViewController: BaseVC<LoginViewModel> {

    private let googleOauthToken = PublishRelay<String>()

    private let headerLabel = UILabel().then {
        $0.text = "MZ의 토막 상식"
        $0.textColor = .black
        $0.font = .headerH1SemiBold
    }

    private let googleLoginButton = GoogleLoginButton()

    override func attribute() {
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

    override func bind() {
        let input = LoginViewModel.Input(oauthToken: googleOauthToken.asObservable())
        let _ = viewModel.transform(input: input)

        googleLoginButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.signInGoogle() })
            .disposed(by: disposeBag)
    }
}

private extension LoginViewController {
    private func signInGoogle() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            guard error == nil else {
                print("구글 로그인에 실패하였습니다.")
                return
            }
            guard let accessToken = result?.user.accessToken.tokenString else { return }
            self.googleOauthToken.accept(accessToken)
        }
    }
}
