import Foundation
import Moya
import RxMoya
import RxSwift
import RxCocoa

class FriendService {
    private let provider = MoyaProvider<FriendAPI>(plugins: [MoyaLoggingPlugin()])
    
    func fetchUsersToRequest() -> Single<[UserEntity]> {
        return provider.rx.request(.fetchUsersToRequest)
            .filterSuccessfulStatusCodes()
            .catch { .error($0) }
            .map(FetchUsersToRequestDTO.self)
            .map { $0.toDomain() }
    }
    
    func sendFriendRequest(_ id: Int) ->  Completable {
        return Completable.create { [weak self] completable in
            guard let self else { return Disposables.create() }
            return provider.rx.request(.sendFriendReqeust(id))
                .subscribe(onSuccess: { _ in
                    completable(.completed)
                }, onFailure: { completable(.error($0)) })
        }
    }
    
    func fetchFriendRequests() -> Single<[UserEntity]> {
        return provider.rx.request(.fetchFriendRequests)
            .filterSuccessfulStatusCodes()
            .catch { .error($0) }
            .map(FetchFriendRequestsDTO.self)
            .map { $0.toDomain() }
    }
    
    func acceptRequest(_ id: Int) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self else { return Disposables.create() }
            return provider.rx.request(.acceptReqeust(id))
                .subscribe(onSuccess: { _ in
                    completable(.completed)
                }, onFailure: { completable(.error($0)) })
        }
    }
    
    func denyRequest(_ id: Int) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self else { return Disposables.create() }
            return provider.rx.request(.denyReqeust(id))
                .subscribe(onSuccess: { _ in
                    completable(.completed)
                }, onFailure: { completable(.error($0)) })
        }
    }
    
    func fetchMyFriends() -> Single<[UserEntity]> {
        return provider.rx.request(.fetchMyFriends)
            .filterSuccessfulStatusCodes()
            .catch { .error($0) }
            .map(FetchMyFriendsDTO.self)
            .map { $0.toDomain() }
    }
}
