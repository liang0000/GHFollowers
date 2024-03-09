//


import UIKit

class GFEmptyStateView: UIView {
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame) // "frame" is the parameter being passed through.
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	convenience init(message: String) {
        self.init(frame: .zero) // shorthand for CGRect(x: 0, y: 0, height: 0, width: 0); without 'frame: .zero', the object exists but doesn't know where to go in view.
        messageLabel.text = message
    }
    
    private func configure() {
		addSubviews(messageLabel, logoImageView)
		configureMessageLabel()
		configureLogoImageView()
    }
	
	private func configureMessageLabel() {
		messageLabel.numberOfLines  = 3
		messageLabel.textColor      = .secondaryLabel
		
		let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSEFirstGen || DeviceTypes.isiPhone8Zoomed ? -80 : -150
		
		NSLayoutConstraint.activate([
			messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: labelCenterYConstant),
			messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
			messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
			messageLabel.heightAnchor.constraint(equalToConstant: 200)
		])
	}
	
	
	private func configureLogoImageView() {
		logoImageView.image = Images.emptyStateLogo
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		
		let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSEFirstGen || DeviceTypes.isiPhone8Zoomed ? 80 : 40
		
		NSLayoutConstraint.activate([
			logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: logoBottomConstant),
			logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
			logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
			logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
		])
	}
}
