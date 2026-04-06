//
//  LoginController.swift
//  Lumora
//
//  Created by Aynur on 03.04.26.
//

import UIKit

class LoginController: BaseController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lumora"
        label.textAlignment = .center
        label.font = UIFont(name: "Noteworthy-Bold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log in or create an account"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var orlabel: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

//    private lazy var infoLabel: UILabel = {
//        let label = UILabel()
//        label.text = ""
//        label.numberOfLines = 0
//        infoLabel.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.setTitle("👁", for: .normal)
        button.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var Continue: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var switchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(toggleMode), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var switchLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue with Google", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue with Facebook", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var appleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue with IOS", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let viewModel = LoginViewModel()
    var test: String?
    var isLogin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func configureUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(nameField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
//        view.addSubview(infoLabel)
        view.addSubview(eyeButton)
        view.addSubview(Continue)
        view.addSubview(orlabel)
        view.addSubview(googleButton)
        view.addSubview(appleButton)
        view.addSubview(facebookButton)
        view.addSubview(switchLabel)
        view.addSubview(switchButton)
    }
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nameField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            eyeButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -10),
            
            Continue.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            Continue.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            Continue.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            Continue.heightAnchor.constraint(equalToConstant: 50),
            
            orlabel.topAnchor.constraint(equalTo: Continue.bottomAnchor, constant: 20),
            orlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            googleButton.topAnchor.constraint(equalTo: orlabel.bottomAnchor, constant: 20),
            googleButton.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            googleButton.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            
            appleButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 10),
            appleButton.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            appleButton.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            appleButton.heightAnchor.constraint(equalToConstant: 50),
            
            facebookButton.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 10),
            facebookButton.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            facebookButton.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            facebookButton.heightAnchor.constraint(equalToConstant: 50),
            
            switchLabel.topAnchor.constraint(equalTo: facebookButton.bottomAnchor, constant: 20),
            switchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            
            switchButton.centerYAnchor.constraint(equalTo: switchLabel.centerYAnchor),
            switchButton.leadingAnchor.constraint(equalTo: switchLabel.trailingAnchor, constant: 5)
        ])
        
    }
    override func configureViewModel() {
        viewModel.success = {
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let tabBar = TabBarController()
                sceneDelegate.coordinator = AppCoordinator(tabBarController: tabBar)
                sceneDelegate.coordinator?.start()
                sceneDelegate.window?.rootViewController = tabBar
            }
        }
        viewModel.error = { error in
            print(error)
        }
        
    }
    
    @objc private func togglePassword() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc private func toggleMode() {
        isLogin.toggle()
        if isLogin {
            subtitleLabel.text = "Log in or Create an account"
            Continue.setTitle("Continue", for: .normal)
            switchLabel.text = "Don't have an account?"
            switchButton.setTitle("Sign Up", for: .normal)
            nameField.isHidden = true
        } else {
            subtitleLabel.text = "Create an account"
            Continue.setTitle("Sign Up", for: .normal)
            switchLabel.text = "Already have an account?"
            switchButton.setTitle("Sign In", for: .normal)
            nameField.isHidden = false
        }
    }
    
    @objc private func actionTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if isLogin {
            viewModel.login(email: email, password: password)
        } else {
            let name = nameField.text ?? ""
            viewModel.register(email: email, password: password, fullName: name)
        }
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
