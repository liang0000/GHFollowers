//


import UIKit

class SearchVC: UIViewController {
    let logoImageView       = UIImageView()
    let usernameTextField   = GFTextField(placeholder: "Enter a username")
	let callToActionButton  = GFButton(title: "Get Followers", colour: .systemGreen, systemImageName: "person.3")
    
    var isUsernameEntered: Bool { !usernameTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
		view.addSubviews(logoImageView, usernameTextField, callToActionButton)
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		usernameTextField.text = ""
//        navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true) // so it won't affect the next screen
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing)) // to end every possible editing when user tap on screen
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() { // to suit with #selector then need @objc
        guard isUsernameEntered else {
            presentGFAlert(title: "Empty Username", message: "Please enter a username. We need to know who to look for.", buttonTitle: "Ok")
            return
        }
		
//		usernameTextField.resignFirstResponder() // pull down keyboard
        
        let followerListVC = FollowerListVC(username: usernameTextField.text!)
//        navigationController?.pushViewController(followerListVC, animated: true)
        show(followerListVC, sender: self)
    }
	
	@objc func toggleChangeLogo() { // just study purpose; not working but something like this
		if logoImageView.image == Images.placeholder {
			logoImageView.image = Images.ghLogo
		} else {
			logoImageView.image = Images.placeholder
		}
		view.layoutIfNeeded()
		
		UIView.animate(withDuration: 0.33, delay: 0, options: .curveEaseIn) {
			self.view.layoutIfNeeded() // force update of any layout changes to be animated
		}
	}
    
    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
		
		let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSEFirstGen || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        usernameTextField.delegate = self // to set extra func
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // to call when hit return on keyboard
        pushFollowerListVC()
        return true
    }
}
