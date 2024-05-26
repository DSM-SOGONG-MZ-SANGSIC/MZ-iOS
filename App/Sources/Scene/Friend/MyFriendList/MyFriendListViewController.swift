import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxRelay

class MyFriendListViewController: BaseVC<MyFriendListViewModel> {
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    private let contentBackView = UIView().then {
        $0.backgroundColor = .white
    }
    private let requestSectionLabel = UILabel().then {
        $0.text = "받은 요청"
        $0.font = UIFont.headerH1SemiBold
        $0.textColor = .black
    }
    private lazy var requestCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 14
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 76)
        $0.register(RequestCell.self, forCellWithReuseIdentifier: "RequestCell")
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.collectionViewLayout = flowLayout
    }
    private let dividerView = UIView().then {
        $0.backgroundColor = .gray200
    }
    private let friendSectionLabel = UILabel().then {
        $0.text = "내 친구 목록"
        $0.font = UIFont.headerH1SemiBold
        $0.textColor = .black
    }
    private lazy var friendCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 14
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 76)
        $0.register(FriendCell.self, forCellWithReuseIdentifier: "FriendCell")
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
            requestSectionLabel,
            requestCollectionView,
            dividerView,
            friendSectionLabel,
            friendCollectionView
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
        requestSectionLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(24)
        }
        requestCollectionView.snp.makeConstraints {
            $0.top.equalTo(requestSectionLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        dividerView.snp.makeConstraints {
            $0.top.equalTo(requestCollectionView.snp.bottom).offset(26)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        friendSectionLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(26)
            $0.left.equalToSuperview().inset(24)
        }
        friendCollectionView.snp.makeConstraints {
            $0.top.equalTo(requestSectionLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(100)
        }
    }

    override func bind() {
        let input = MyFriendListViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.requests
            .bind(to: requestCollectionView.rx.items(
                cellIdentifier: "RequestCell",
                cellType: RequestCell.self
            )) { _, user, cell in
                cell.userName = user.name
                cell.imageURL = user.imageURL
            }.disposed(by: disposeBag)
        
        output.myFriends
            .bind(to: friendCollectionView.rx.items(
                cellIdentifier: "FriendCell",
                cellType: FriendCell.self
            )) { _, user, cell in
                cell.userName = user.name
                cell.imageURL = user.imageURL
            }.disposed(by: disposeBag)
    }
}
