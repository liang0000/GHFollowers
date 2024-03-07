//


import UIKit

class GFAlertContainerView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		// view controller don't need to know
		backgroundColor       = .systemBackground
		layer.cornerRadius    = 16
		layer.borderWidth     = 2
		layer.borderColor     = UIColor.white.cgColor // to specifically for .layer
		translatesAutoresizingMaskIntoConstraints = false
	}
}
