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
    
	convenience init(title: String, colour: UIColor, systemImageName: String) {
        self.init(frame: .zero)
		set(title: title, colour: colour, systemImageName: systemImageName)
    }
    
    private func configure() {
		configuration = .tinted() // apple default button style
		configuration?.cornerStyle = .medium
		translatesAutoresizingMaskIntoConstraints = false // to have auto layout
//		setTitle("Done", for: .normal)
//		setTitleColor(.white, for: .normal)
//		titleLabel?.text = "Done"
//		titleLabel?.textColor = .white
//		titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
//		layer.cornerRadius = 10
//		backgroundColor = .green
    }
	
	final func set( title: String, colour: UIColor, systemImageName: String) {
		configuration?.title = title
		configuration?.baseBackgroundColor = colour
		configuration?.baseForegroundColor = colour // text colour
		
		configuration?.image = UIImage(systemName: systemImageName)
		configuration?.imagePadding = 6
		configuration?.imagePlacement = .leading
	}
}

#Preview {
	GFButton(title: "Test Button", colour: .green, systemImageName: "pencil")
}
