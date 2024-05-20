import Foundation
import Moya
import RxMoya
import RxSwift
import RxCocoa

class OauthService {
    private let provider = MoyaProvider<OauthAPI>(plugins: [MoyaLoggingPlugin()])

    func connectWithGoogleOauth(token: String) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self else { return Disposables.create() }
            return provider.rx.request(.googleOauth(token: token))
                    .map(OauthResponse.self)
                    .subscribe(onSuccess: {
                        TokenStorage.shared.accessToken = $0.accessToken
                        completable(.completed)
                    }, onFailure: { completable(.error($0)) })
        }
    }
}
