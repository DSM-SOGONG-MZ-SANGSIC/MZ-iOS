import UIKit
import SnapKit
import Then

enum CellType {
    case request
    case friend
}

class FriendCell: UITableViewCell {
    private var buttonTapped: ((Int) -> ()) = { _ in }
    
    var userName: String {
        get { userLabel.text ?? "" }
        set { userLabel.text = newValue }
    }
    var userId: Int = 0
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.gray900.cgColor
        self.layer.borderWidth = 1.5
        
        self.addSubViews(
            circleImageView,
            userLabel
        )
    
        setUpView()
        
        requestButton.addAction(UIAction { [weak self] _ in
            self?.buttonTapped((self?.userId)!)
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
    
    private func buttonOnTapped(buttonTapped: @escaping (Int) -> ()) {
        self.buttonTapped = buttonTapped
    }
}
