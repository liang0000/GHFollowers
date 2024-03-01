//


import UIKit

class GFItemInfoVC: UIViewController {
	let stackView 		= UIStackView()
	let itemInfoViewOne = GFItemInfoView()
	let itemInfoViewTwo = GFItemInfoView()
	let actionButton	= GFButton()
	
	var user: User!
	weak var delegate: UserInfoVCDelegate!
	
	init(user: User) {
		super.init(nibName: nil, bundle: nil)
		self.user = user
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureBackgroundView()
		configureActionButton()
		layoutUI()
		configureStackView()
    }
	
	private func configureBackgroundView() {
		view.layer.cornerRadius = 18
		view.backgroundColor	= .secondarySystemBackground // light grey
	}
	
	private func configureStackView() {
		stackView.axis 			= .horizontal // HStack
		stackView.distribution 	= .equalSpacing
//		stackView.spacing		= 10 // min spacing
		
		stackView.addArrangedSubview(itemInfoViewOne)
		stackView.addArrangedSubview(itemInfoViewTwo)
	}
	
	private func configureActionButton() {
		actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
	}
	
	@objc func actionButtonTapped() {} // because this is superclass
	
	private func layoutUI() {
		let padding: CGFloat = 20
		
		view.addSubview(stackView)
		view.addSubview(actionButton)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			stackView.heightAnchor.constraint(equalToConstant: 50),
			
			actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
			actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			actionButton.heightAnchor.constraint(equalToConstant: 44)
		])
	}
}
