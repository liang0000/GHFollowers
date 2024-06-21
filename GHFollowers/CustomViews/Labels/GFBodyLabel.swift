//


import UIKit

class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        textColor 							= .secondaryLabel
		font 								= UIFont.preferredFont(forTextStyle: .body) // able to dynamic
		adjustsFontForContentSizeCategory 	= true // enable dynamic
        adjustsFontSizeToFitWidth 			= true // to have smaller font size when have longer text
        minimumScaleFactor 					= 0.75
        lineBreakMode 						= .byWordWrapping // to make text into multiple line if too long
        translatesAutoresizingMaskIntoConstraints = false
    }
}
