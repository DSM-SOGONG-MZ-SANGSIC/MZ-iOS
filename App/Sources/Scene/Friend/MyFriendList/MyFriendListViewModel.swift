import Foundation
import RxFlow
import RxRelay
import RxSwift

class MyFriendListViewModel: ViewModelType, Stepper {
    var steps: PublishRelay<Step> = .init()
    var disposeBag: DisposeBag = .init()
    
    private let friendService: FriendService
    
    init(friendService: FriendService) {
        self.friendService = friendService
    }
    
    struct Input {
    }
    
    struct Output {
        let requests: PublishRelay<[UserEntity]>
        let myFriends: PublishRelay<[UserEntity]>
    }
    
    func transform(input: Input) -> Output {
        let requests = PublishRelay<[UserEntity]>()
        let myFriends = PublishRelay<[UserEntity]>()
        
        Observable.just(())
            .flatMap { _ in
                self.friendService.fetchFriendRequests()
            }
            .bind(to: requests)
            .disposed(by: disposeBag)
        Observable.just(())
            .flatMap { _ in
                self.friendService.fetchMyFriends()
            }
            .bind(to: myFriends)
            .disposed(by: disposeBag)
        
        return Output(requests: requests, myFriends: myFriends)
    }
}
