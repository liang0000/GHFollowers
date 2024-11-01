//


import UIKit

// SceneDelegate.swift
//window = UIWindow(frame: windowScene.coordinateSpace.bounds)
//window?.windowScene = windowScene
//window?.rootViewController = UINavigationController(rootViewController: ViewController())
//window?.makeKeyAndVisible()

class HomeVC: UIViewController {
	var nextButton = UIButton(frame: .zero)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemGray
		view.addSubview(nextButton)
		
		nextButton.configuration = .tinted()
		nextButton.configuration?.title = "Next"
		nextButton.configuration?.baseBackgroundColor = .systemBlue
		nextButton.configuration?.baseForegroundColor = .white
		nextButton.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
		nextButton.translatesAutoresizingMaskIntoConstraints = false
		
		
		NSLayoutConstraint.activate([
			nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			nextButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	@objc func nextClick() {
		let nextScreen = SquidVC()
		show(nextScreen, sender: self)
	}
}
