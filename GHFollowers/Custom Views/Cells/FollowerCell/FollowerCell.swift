//


import UIKit
import SwiftUI

class FollowerCell: UICollectionViewCell {
    static let reuseID 	= "FollowerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel 	= GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
//        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	func set(follower: Follower) { // SwiftUI way
		contentConfiguration = UIHostingConfiguration { FollowerView(follower: follower) }
	}
    
//    func set1(follower: Follower) { // UIKit way
//        usernameLabel.text = follower.login
//        avatarImageView.downloadImage(fromURL: follower.avatarUrl)
//    }
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20) // reason to be 20 is because letters like y g j's bottom will be cut off if is 16 (fontSize)
        ])
    }
}
