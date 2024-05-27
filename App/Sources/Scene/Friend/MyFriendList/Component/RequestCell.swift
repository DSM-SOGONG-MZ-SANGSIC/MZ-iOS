import UIKit
import SnapKit
import Then

class RequestCell: UICollectionViewCell {
    private var acceptTapped: (() -> ())?
    private var denyTapped: (() -> ())?
    
    var userName: String {
        get { userLabel.text ?? "" }
        set { userLabel.text = newValue }
    }
    var imageURL: String = ""
    
    private let circleImageView = UIImageView().then {
        $0.image = UIImage(systemName: "circle.fill")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 24
        $0.layer.borderColor = UIColor.gray500.cgColor
        $0.layer.borderWidth = 1.5
    }
    private let userLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .headerH2Medium
    }
    private let acceptButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "checkmark"), for: .normal)
        $0.tintColor = UIColor(named: "green")
    }
    private let denyButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = UIColor(named: "red")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.gray900.cgColor
        self.layer.borderWidth = 1.5
        
        circleImageView.kf.setImage(with: URL(string: imageURL))
        
        self.addSubViews(
            circleImageView,
            userLabel,
            denyButton,
            acceptButton
        )
    
        setUpView()
        
        acceptButton.addAction(UIAction { [weak self] _ in
            self?.acceptTapped!()
        }, for: .allTouchEvents)
        denyButton.addAction(UIAction { [weak self] _ in
            self?.denyTapped!()
        }, for: .allTouchEvents)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        circleImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(14)
            $0.left.equalToSuperview().inset(18)
            $0.width.height.equalTo(48)
        }
        userLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(circleImageView.snp.right).offset(36)
        }
        denyButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(30)
        }
        acceptButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(denyButton.snp.left).offset(-34)
        }
    }
    
    func acceptTapped(buttonTapped: @escaping () -> ()) {
        self.acceptTapped = buttonTapped
    }
    func denyTapped(buttonTapped: @escaping () -> ()) {
        self.denyTapped = buttonTapped
    }
}
