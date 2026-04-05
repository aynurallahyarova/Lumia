//
//  LoginController.swift
//  Lumora
//
//  Created by Aynur on 03.04.26.
//

import UIKit

class LoginController: BaseController {
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isUserInteractionEnabled = true
        textField.isEnabled = true
        textField.isHighlighted = false
        textField.isSelected = false
        return textField
    }()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    let viewModel = LoginViewModel()
    var test: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func configureUI() {
        
    }
    override func configureConstraints() {
        
    }
    override func configureViewModel() {
        
    }
//    private func configureAdapter() {
//        adapter = LoginAdapter(controller: self)
//        adapter?.completion = { state in
//            switch state {
//            case .success(let user):
//                print(user.email)
//                self.infoLabel.text = ""
//            case .failure(let error):
//                self.infoLabel.text = error
//            case .loading:
//                self.infoLabel.text = "Loading..."
//            }
//        }
//    }
    
//    @IBAction func signupButtonTapped(_ sender: Any) {
//        guard let email = emailTextField.text,
//              let password = passwordTextField.text else { return }
//                
//        adapter?.login(type: .email(email, password), controller: self)
//    }
    
//    @IBAction func loginAppleAction(_ sender: Any) {
//        adapter?.login(type: .apple, controller: self)
//    }
//    
//    @IBAction func loginFacebookAction(_ sender: Any) {
//        adapter?.login(type: .facebook, controller: self)
//    }
//    
//    @IBAction func loginGoogleAction(_ sender: Any) {
//        adapter?.login(type: .google, controller: self)
//    }
//    


}
