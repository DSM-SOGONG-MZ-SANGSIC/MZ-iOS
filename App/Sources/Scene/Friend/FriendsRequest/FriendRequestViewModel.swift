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
    }
    
    struct Input {
        let viewDidAppear: Observable<Void>
        let toFriendListButtonTapped: Signal<Void>
    }

    struct Output {
        let userList: BehaviorRelay<[UserEntity]>
    }

    func transform(input: Input) -> Output {
        let userList = BehaviorRelay<[UserEntity]>(value: [])
        
        input.toFriendListButtonTapped.asObservable()
            .map { MZStep.myFriendListRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        input.viewDidAppear
            .flatMap { _ in
                self.friendService.fetchUsersToRequest()
            }
            .bind(to: userList)
            .disposed(by: disposeBag)
        
        return Output(userList: userList)
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
