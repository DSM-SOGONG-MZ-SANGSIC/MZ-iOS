import UIKit
import SnapKit
import Then

class FriendCell: UICollectionViewCell {
    var userName: String {
        get { userLabel.text ?? "" }
        set { userLabel.text = newValue }
    }
    var imageURL: String = ""
    
    private let circleImageView = UIImageView().then {
        $0.image = UIImage(systemName: "circle.fill")
        $0.contentMode = .scaleAspectFit
    }
    private let userLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .headerH2Medium
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
            userLabel
        )
    
        setUpView()
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
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.left.equalTo(circleImageView.snp.right).offset(36)
        }
    }
}
