import Foundation
import Moya
import RxMoya
import RxSwift
import RxCocoa

class ProfileService {
    private let provider = MoyaProvider<ProfileAPI>(plugins: [MoyaLoggingPlugin()])
    
    func fetchMyProfile() -> Single<ProfileEntity> {
        return provider.rx.request(.fetchMyProfile)
            .map(FetchMyProfileDTO.self)
            .map { $0.toDomain() }
    }
    
    func fetchPercentage(userId: Int) -> Single<PercentageEntity> {
        return provider.rx.request(.fetchPercentages(userId: userId))
            .map(FetchPercentageDTO.self)
            .map { $0.toDomain() }
    }
}
