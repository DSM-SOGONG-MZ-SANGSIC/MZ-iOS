import UIKit
import SnapKit
import Then

class SavedProblumCell: UITableViewCell {
    static let identifier = "SavedProblumCell"

    private let contentBackView = UIView().then {
        $0.layer.borderColor = UIColor.gray900.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
    }

    private let tagBackView = UIView().then {
        $0.backgroundColor = .gray600
        $0.layer.cornerRadius =  17
    }
    private let tagLabel = UILabel().then {
        $0.font = .bodyB2Medium
        $0.textColor = .white
    }

    private let contentLabel = UILabel().then {
        $0.font = .headerH3Medium
        $0.textColor = .black
        $0.numberOfLines = 0
    }

    private func addView() {
        addSubview(contentBackView)
        contentBackView.addSubViews(
            tagBackView,
            contentLabel
        )
        tagBackView.addSubview(tagLabel)
    }

    private func setlayout() {
        contentBackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalToSuperview()
            $0.bottom.equalTo(contentLabel.snp.bottom).offset(14)
            $0.bottom.equalToSuperview().inset(18)
        }
        tagBackView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(14)
            $0.height.equalTo(34)
            $0.trailing.equalTo(tagLabel).offset(12)
        }
        tagLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(tagBackView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}

extension SavedProblumCell {
    func setup(with entity: SavedQuizEntity) {
        tagLabel.text = "# \(entity.category.categoryName)"
        contentLabel.text = entity.content
        selectionStyle = .none
        addView()
        setlayout()
    }
}
