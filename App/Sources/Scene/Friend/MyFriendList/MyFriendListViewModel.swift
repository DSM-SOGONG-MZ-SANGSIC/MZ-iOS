import Foundation
import RxFlow
import RxRelay
import RxSwift
import RxCocoa

class MyFriendListViewModel: ViewModelType, Stepper {
    var steps: PublishRelay<Step> = .init()
    var disposeBag: DisposeBag = .init()
    
    private let friendService: FriendService
    
    init(friendService: FriendService) {
        self.friendService = friendService
    }
    
    let requests = BehaviorRelay<[UserEntity]>(value: [])
    let myFriends = BehaviorRelay<[UserEntity]>(value: [])
    
    struct Input {
        let index: Signal<IndexPath>
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        input.index.asObservable()
            .map { MZStep.friendPercentageRequired(userId: self.myFriends.value[$0.row].id) }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
    
    func fetchRequests() {
        Observable.just(())
            .flatMap { _ in
                self.friendService.fetchFriendRequests()
            }
            .bind(to: self.requests)
            .disposed(by: disposeBag)
    }
    
    func fetchMyFriends() {
        Observable.just(())
            .flatMap { _ in
                self.friendService.fetchMyFriends()
            }
            .bind(to: self.myFriends)
            .disposed(by: disposeBag)
    }
    
    func acceptRequest(_ userId: Int) {
        self.friendService.acceptRequest(userId)
            .subscribe { [self] in
                switch $0 {
                case .completed:
                    self.fetchRequests()
                    self.fetchMyFriends()
                case .error:
                    print("Error Occured")
                }
            }.disposed(by: disposeBag)
    }
    
    func denyRequest(_ userId: Int) {
        self.friendService.denyRequest(userId)
            .subscribe { [self] in
                switch $0 {
                case .completed:
                    self.fetchRequests()
                    self.fetchMyFriends()
                case .error:
                    print("Error Occured")
                }
            }.disposed(by: disposeBag)
    }
}
