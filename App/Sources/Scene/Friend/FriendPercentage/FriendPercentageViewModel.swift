import Foundation
import RxFlow
import RxRelay
import RxSwift
import RxCocoa

class FriendPercentageViewModel: ViewModelType, Stepper {
    var steps: PublishRelay<Step> = .init()
    var disposeBag: DisposeBag = .init()
    
    private let profileService: ProfileService
    
    init(profileService: ProfileService) {
        self.profileService = profileService
    }
    
    let requests = BehaviorRelay<[UserEntity]>(value: [])
    let myFriends = BehaviorRelay<[UserEntity]>(value: [])
    var userName: String = ""
    var chartData: [ChartData] = []
    
    struct Input {
        let userId: Observable<Int>
    }
    
    struct Output {
        let isCalculated: BehaviorRelay<Bool>
    }
    
    func transform(input: Input) -> Output {
        let isCalculated = BehaviorRelay<Bool>(value: false)

        input.userId
            .flatMap { userId in
                self.profileService.fetchPercentage(userId: userId)
            }
            .subscribe(
                with: self,
                onNext: { [self] _, data in
                    userName = data.name
                    chartData = []
                    
                    data.percentage.forEach {
                        chartData.append(
                            ChartData(
                                category: $0.category.categoryName,
                                percentage: Int(Double($0.correct) / Double($0.solved) * 100)
                            )
                        )
                    }
                    print(chartData)
                    isCalculated.accept(true)
                }
            ).disposed(by: disposeBag)
        return Output(isCalculated: isCalculated)
    }
}
