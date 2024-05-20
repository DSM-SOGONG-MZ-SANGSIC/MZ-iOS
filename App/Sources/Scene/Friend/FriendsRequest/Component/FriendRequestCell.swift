import UIKit
import SnapKit
import Then

class FriendRequestCell: UICollectionViewCell {
    public var userName: String {
        get { userLabel.text ?? "" }
        set { userLabel.text = newValue }
    }
    private var buttonTapped: (() -> ()) = {}
    
    private let circleImageView = UIImageView().then {
        $0.image = UIImage(systemName: "circle.fill")
        $0.contentMode = .scaleAspectFit
    }
    private let userLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .headerH2Medium
    }
    private let requestButton = UIButton(type: .system).then {
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        config.image = UIImage(systemName: "person.fill.badge.plus")?.withTintColor(.black)
        config.imagePadding = 12
        config.imagePlacement = .trailing
        config.baseBackgroundColor = .gray200
        config.baseForegroundColor = .gray900
        $0.configuration = config
        $0.setTitle("친구 추가하기", for: .normal)
        $0.titleLabel?.font = .headerH3Light
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.gray900.cgColor
        self.layer.borderWidth = 1.5
        
        self.addSubViews(
            circleImageView,
            userLabel,
            requestButton
        )
    
        setUpView()
        
        requestButton.addAction(UIAction { [weak self] _ in
            self?.buttonTapped()
        }, for: .allTouchEvents)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        circleImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14)
            $0.left.equalToSuperview().inset(18)
            $0.width.height.equalTo(90)
        }
        userLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalTo(circleImageView.snp.right).offset(38)
        }
        requestButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.left.equalTo(circleImageView.snp.right).offset(38)
            $0.top.equalTo(userLabel.snp.bottom).offset(9)
        }
    }
    
    private func buttonOnTapped(buttonTapped: @escaping () -> ()) {
        self.buttonTapped = buttonTapped
    }
}
