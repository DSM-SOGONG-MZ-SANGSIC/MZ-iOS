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
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 14
            $0.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 76)
        }
    ).then {
        $0.register(RequestCell.self, forCellWithReuseIdentifier: "RequestCell")
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
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
        $0.isScrollEnabled = false
        $0.collectionViewLayout = flowLayout
    }

    override func attribute() {
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationItem.title = "친구 목록"
        
        viewModel.fetchRequests()
        viewModel.fetchMyFriends()
    }
    
    override func addView() {
        contentBackView.addSubViews(
            requestSectionLabel,
            requestCollectionView,
            dividerView,
            friendSectionLabel,
            friendCollectionView
        )
        scrollView.addSubview(contentBackView)
        view.addSubview(scrollView)
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentBackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.bottom.greaterThanOrEqualToSuperview()
        }
        requestSectionLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(24)
        }
        requestCollectionView.snp.makeConstraints {
            $0.top.equalTo(requestSectionLabel.snp.bottom).offset(20)
            $0.height.equalTo(90).priority(.low)
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
            $0.top.equalTo(friendSectionLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(20).priority(.low)
            $0.bottom.equalToSuperview().inset(28)
        }
    }

    override func bind() {
        let input = MyFriendListViewModel.Input(index: friendCollectionView.rx.itemSelected.asSignal())
        let _ = viewModel.transform(input: input)
        
        viewModel.requests
            .bind(to: requestCollectionView.rx.items(
                cellIdentifier: "RequestCell",
                cellType: RequestCell.self
            )) { index, user, cell in
                cell.userName = user.name
                cell.imageURL = user.imageURL
                
                cell.acceptTapped {
                    self.viewModel.acceptRequest(user.id)
                }
                cell.denyTapped {
                    self.viewModel.denyRequest(user.id)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.myFriends
            .bind(to: friendCollectionView.rx.items(
                cellIdentifier: "FriendCell",
                cellType: FriendCell.self
            )) { _, user, cell in
                cell.userName = user.name
                cell.imageURL = user.imageURL
            }.disposed(by: disposeBag)
        
        requestCollectionView.rx.observe(CGSize.self, "contentSize")
            .compactMap { $0?.height }
            .subscribe(onNext: { [weak self] height in
                self?.requestCollectionView.snp.updateConstraints {
                    $0.height.equalTo(height)
                }
            }).disposed(by: disposeBag)
        
        friendCollectionView.rx.observe(CGSize.self, "contentSize")
            .compactMap { $0?.height }
            .subscribe(onNext: { [weak self] height in
                self?.friendCollectionView.snp.updateConstraints {
                    $0.height.equalTo(height)
                }
            }).disposed(by: disposeBag)
    }
}
