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
        self.fetchRequests()
        self.fetchMyFriends()
    }
    
    let requests = BehaviorRelay<[UserEntity]>(value: [])
    let myFriends = BehaviorRelay<[UserEntity]>(value: [])
    
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
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
                    self.friendService.fetchFriendRequests().asObservable()
                        .bind(to: requests)
                        .disposed(by: disposeBag)
                    self.friendService.fetchMyFriends().asObservable()
                        .bind(to: myFriends)
                        .disposed(by: disposeBag)
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
                    self.friendService.fetchFriendRequests().asObservable()
                        .bind(to: requests)
                        .disposed(by: disposeBag)
                    self.friendService.fetchMyFriends().asObservable()
                        .bind(to: myFriends)
                        .disposed(by: disposeBag)
                case .error:
                    print("Error Occured")
                }
            }.disposed(by: disposeBag)
    }
}
