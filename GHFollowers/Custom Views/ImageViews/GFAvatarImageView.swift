//


import UIKit

class GFAvatarImageView: UIImageView {
	let placeholderImage = Images.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true // to have cornerRadius
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
	
	func downloadImage(fromURL url: String) {
		Task { image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage }
	}
}
