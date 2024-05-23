import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class FriendRequestViewController: BaseVC<FriendRequestViewModel> {
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.contentInsetAdjustmentBehavior = .never
    }
    private let contentBackView = UIView().then {
        $0.backgroundColor = .white
    }
    private let titleLabel = UILabel().then {
        $0.text = "👥 친구 추가"
        $0.font = UIFont.headerH1SemiBold
        $0.textColor = .black
    }
    private let toFriendListButton = UIButton(type: .system).then {
        $0.setTitle("친구 목록                                           ", for: .normal)
        $0.setTitleColor(.gray900, for: .normal)
        $0.titleLabel?.font = .headerH3Medium
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.tintColor = .gray900
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.gray900.cgColor
        $0.layer.borderWidth = 1.5
    }
    private let dividerView = UIView().then {
        $0.backgroundColor = .gray200
    }
    private lazy var requestCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 118)
        $0.register(FriendRequestCell.self, forCellWithReuseIdentifier: "FriendRequestCell")
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.collectionViewLayout = flowLayout
    }
    
    override func attribute() {
        view.backgroundColor = .white
    }
    
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentBackView)
        contentBackView.addSubViews(
            titleLabel,
            toFriendListButton,
            dividerView,
            requestCollectionView
        )
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentBackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
        }
        toFriendListButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(38)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(64)
        }
        dividerView.snp.makeConstraints {
            $0.top.equalTo(toFriendListButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        requestCollectionView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100)
        }
    }
    
    override func bind() {
        let input = FriendRequestViewModel.Input(
            toFriendListButtonTapped: toFriendListButton.rx.tap.asSignal(),
            requestUserIndex: requestCollectionView.rx.itemSelected.asSignal()
        )
        let output = viewModel.transform(input: input)
        
        output.userList
            .bind(to: requestCollectionView.rx.items(
                cellIdentifier: "FriendRequestCell",
                cellType: FriendRequestCell.self
            )) { _, user, cell in
                cell.userName = user.name
                cell.imageURL = user.imageURL
            }.disposed(by: disposeBag)
        
        requestCollectionView.rx.itemSelected
            .subscribe(onNext: { _ in
                
            }).disposed(by: disposeBag)
    }
}

