import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach(addSubview(_:))
    }

    func addSubViews(_ views: [UIView]) {
        views.forEach(addSubview(_:))
    }
}
