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
    
    func fetchFriendRequests() -> Single<[UserEntity]> {
        return provider.rx.request(.fetchFriendRequests)
            .filterSuccessfulStatusCodes()
            .catch { .error($0) }
            .map(FetchFriendRequestsDTO.self)
            .map { $0.toDomain() }
    }
    
    func fetchMyFriends() -> Single<[UserEntity]> {
        return provider.rx.request(.fetchMyFriends)
            .filterSuccessfulStatusCodes()
            .catch { .error($0) }
            .map(FetchMyFriendsDTO.self)
            .map { $0.toDomain() }
    }
}
