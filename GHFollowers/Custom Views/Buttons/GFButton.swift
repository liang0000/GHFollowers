//


import UIKit

class GFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
    private func configure() {
//		configuration = .filled()
//		configuration?.title = "Next"
//		configuration?.baseBackgroundColor = .systemRed
        layer.cornerRadius 		= 10
//		setTitleColor(.white, for: .normal)
        titleLabel?.textColor 	= .white
        titleLabel?.font 		= UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false // to have auto layout
    }
	
	func set(backgroundColor: UIColor, title: String) {
		self.backgroundColor = backgroundColor
		setTitle(title, for: .normal)
	}
}
