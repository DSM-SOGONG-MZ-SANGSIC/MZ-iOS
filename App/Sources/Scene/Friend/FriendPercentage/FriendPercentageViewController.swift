import UIKit
import SwiftUI
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxRelay

class FriendPercentageViewController: BaseVC<FriendPercentageViewModel> {
    let fetchPercentage = PublishRelay<Int>()
    var userId: Int?
    
    private let xButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black
    }
    private let backView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    private lazy var chartView = UIHostingController(rootView: ChartView())
    
    override func attribute() {
        view.backgroundColor = .white.withAlphaComponent(0.1)
        self.navigationController?.isToolbarHidden = true
        chartView.view.translatesAutoresizingMaskIntoConstraints = false
        chartView.view.frame = view.frame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let userId else { return }
        fetchPercentage.accept(userId)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func addView() {
        view.addSubview(backView)
        
        backView.addSubViews([
            xButton,
            chartView.view
        ])
    }
    
    override func setLayout() {
        backView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(28)
            $0.verticalEdges.equalToSuperview().inset(200)
        }
        xButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.equalToSuperview().inset(30)
            $0.left.equalToSuperview().inset(24)
        }
        chartView.view.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(240)
        }
    }

    override func bind() {
        let input = FriendPercentageViewModel.Input(userId: self.fetchPercentage.asObservable())
        let output = viewModel.transform(input: input)
        
        output.isCalculated
            .subscribe(onNext: { [self] in
                if $0 == true {
                    chartView = UIHostingController(rootView: ChartView(
                        userName: viewModel.userName, stats: viewModel.chartData
                    ))
                }
                view.setNeedsLayout()
            }).disposed(by: disposeBag)
        
        xButton.rx.tap 
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
}
