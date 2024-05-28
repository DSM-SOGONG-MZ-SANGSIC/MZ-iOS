import Foundation
import RxFlow
import RxRelay
import RxSwift
import RxCocoa

class FriendRequestViewModel: ViewModelType, Stepper {
    var disposeBag = DisposeBag()
    var steps: PublishRelay<Step> = .init()
    
    private let friendService: FriendService
    
    init(friendService: FriendService) {
        self.friendService = friendService
        self.fetchUsers()
    }
    
    let userList = BehaviorRelay<[UserEntity]>(value: [])
    
    struct Input {
        let toFriendListButtonTapped: Signal<Void>
    }

    struct Output {
    }

    func transform(input: Input) -> Output {
        input.toFriendListButtonTapped.asObservable()
            .map { MZStep.myFriendListRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        return Output()
    }
    
    func fetchUsers() {
        Observable.just(())
            .flatMap { _ in
                self.friendService.fetchUsersToRequest()
            }
            .bind(to: userList)
            .disposed(by: disposeBag)
    }
    
    func requestButtonTapped(_ userId: Int) -> Bool {
        var isRequestSucceeded = false
        
        self.friendService.sendFriendRequest(userId)
            .subscribe {
                switch $0 {
                case .completed:
                    isRequestSucceeded = true
                case .error:
                    isRequestSucceeded = false
                }
            }.disposed(by: disposeBag)
        
        return isRequestSucceeded
    }
}
