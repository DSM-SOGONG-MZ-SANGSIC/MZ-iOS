import Foundation

import RxSwift
import RxCocoa
import RxFlow

class LoginViewModel: ViewModelType, Stepper {
    var steps: PublishRelay<Step> = .init()
    var disposeBag: DisposeBag = .init()

    private let oauthService: OauthService

    init(oauthService: OauthService) {
        self.oauthService = oauthService
    }

    struct Input {
        let oauthToken: Observable<String>
    }
    struct Output { }

    func transform(input: Input) -> Output {
        input.oauthToken
            .flatMap { token -> Single<Step> in
                self.oauthService.connectWithGoogleOauth(token: token)
                    .andThen(.just(MZStep.tabBarRequired))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
