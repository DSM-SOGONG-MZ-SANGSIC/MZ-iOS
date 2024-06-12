import UIKit

import RxSwift
import RxRelay
import RxFlow

class BaseVC<ViewModel: ViewModelType>: UIViewController {
    let disposeBag = DisposeBag()

    let viewDidLoadRelay = PublishRelay<Void>()
    let viewWillAppearRelay = PublishRelay<Void>()
    let viewDidAppearRelay = PublishRelay<Void>()

    let viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearRelay.accept(())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bind()
        viewDidAppearRelay.accept(())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        viewDidLoadRelay.accept(())
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addView()
        setLayout()
    }

    /// - addSubView 코드를 작성하는 함수
    /// - viewDidLayoutSubviews()에서 작동
    func addView() { }

    /// - 레이아웃 관련 코드를 작성하는 함수
    /// - viewDidLayoutSubviews()에서 작동
    func setLayout() { }

    /// - 초기 설정 코드를 작성하는 함수
    /// - viewDidLoad()에서 작동
    func attribute() { }

    /// - 뷰 바인딩 코드를 작성하는 함수
    /// - viewDidLoad()에서 작동
    func bind() {}
}
