import Foundation
import RxRelay
import RxSwift

class FriendRequestViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    let users = BehaviorRelay<[String]>(value: ["가나다", "김첨지", "홍길동", "나라마", "마바사", "아자차", "카타파"])

    struct Input {
    }

    struct Output {
    }

    func transform(input: Input) -> Output {
        return Output()
    }
}
