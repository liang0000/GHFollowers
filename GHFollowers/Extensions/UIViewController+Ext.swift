	//


import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
	func presentGFAlert(title: String, message: String, buttonTitle: String) {
		let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
		alertVC.modalPresentationStyle = .overFullScreen
		alertVC.modalTransitionStyle = .crossDissolve // to animate
		present(alertVC, animated: true)
	}
	
	func presentSafariVC(with url: URL) {
		let safariVC = SFSafariViewController(url: url)
		safariVC.preferredControlTintColor = .systemGreen
		present(safariVC, animated: true)
	}
	
	func showLoadingView() {
		containerView = UIView(frame: view.bounds) // fill the whole screen
		view.addSubview(containerView)
		
		containerView.backgroundColor = .systemBackground
		containerView.alpha = 0 // opacity
		
		UIView.animate(withDuration: 0.25) {
			containerView.alpha = 0.8
		}
		
		let activityIndicator = UIActivityIndicatorView(style: .large)
		containerView.addSubview(activityIndicator)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
		])
		
		activityIndicator.startAnimating()
	}
	
	func dismissLoadingView() {
		DispatchQueue.main.async {
			containerView.removeFromSuperview()
			containerView = nil
		}
	}
	
	func showEmptyStateView(with message: String, in view: UIView) {
		let emptyStateView = GFEmptyStateView(message: message)
		emptyStateView.frame = view.bounds
		view.addSubview(emptyStateView)
	}
}
