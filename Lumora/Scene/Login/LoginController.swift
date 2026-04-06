//
//  LoginController.swift
//  Lumora
//
//  Created by Aynur on 03.04.26.
//

import UIKit

class LoginController: BaseController {
    
    private lazy var mainStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(appLogoLabel)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(continueButton)
        stack.addArrangedSubview(orSeperatorStack)
        stack.addArrangedSubview(googleButton)
        stack.addArrangedSubview(iosButton)
        stack.addArrangedSubview(facebookButton)
        stack.addArrangedSubview(signUpButton)
        
        stack.setCustomSpacing(32, after: appLogoLabel)
        stack.setCustomSpacing(24, after: orSeperatorStack)
        return stack
    }()
    
    private lazy var appLogoLabel: UILabel = {
        let label = UILabel()
        label.text = "Lumora"
        label.textAlignment = .center
        label.font = UIFont(name: "Bradley Hand", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log in or create an account"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var orlabel: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var orSeperatorStack: UIStackView = {
        let right = UIView()
        let left = UIView()
        
        [left, right].forEach {
            $0.backgroundColor = .systemGray4
            $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
        
        let stack = UIStackView(arrangedSubviews: [left, orlabel, right])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        
        left.widthAnchor.constraint(equalTo: right.widthAnchor).isActive = true
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "eye"), for: .normal)
        btn.tintColor = .label
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        textField.rightView = btn
        textField.rightViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    //    private lazy var infoLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = ""
    //        label.numberOfLines = 0
    //        infoLabel.translatesAutoresizingMaskIntoConstraints = false
    //        return label
    //    }()
    
    
    private let continueButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Continue", for: .normal)
        b.layer.cornerRadius = 4
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .black
        b.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        b.heightAnchor.constraint(equalToConstant: 44).isActive = true
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(handleLoginRequest), for: .touchUpInside)
        return b
    }()
    
    private func createSocialButton(title: String, image: UIImage?) -> UIButton {
        var config = UIButton.Configuration.plain()
        
        if let originalImage = image {
            let size = CGSize(width: 24, height: 24)
            let renderer = UIGraphicsImageRenderer(size: size)
            let scaledImage = renderer.image { _ in
                originalImage.draw(in: CGRect(origin: .zero, size: size))
            }
            config.image = scaledImage.withRenderingMode(.alwaysOriginal)
        }
        
        config.title = title
        config.imagePadding = 12
        config.imagePlacement = .leading
        config.baseForegroundColor = .label
        config.background.strokeWidth = 1
        config.background.strokeColor = .systemGray4
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.contentHorizontalAlignment = .center
        
        return button
    }
    
    private lazy var googleButton = createSocialButton(title: "Continue with Google", image: UIImage(named: "google_logo"))
    private lazy var iosButton = createSocialButton(title: "Continue with IOS", image: UIImage(systemName: "apple.logo"))
    private lazy var facebookButton = createSocialButton(title: "Continue with Facebook", image: UIImage(named: "facebook_logo"))
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        let title = NSMutableAttributedString(
            string: "Don't have an account?",
            attributes: [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 14)]
        )
        
        let signUpPart = NSAttributedString(
            string: " Sign Up",
            attributes: [.foregroundColor: UIColor.black,
                         .font: UIFont.boldSystemFont(ofSize: 14)]
        )
        title.append(signUpPart)
        button.setAttributedTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    
    private let viewModel: LoginViewModel = {
        let vm = LoginViewModel()
        return vm
    }()
    
    var test: String?
    var isLogin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func configureUI() {
        view.addSubview(mainStackView)
        view.backgroundColor = .systemBackground
    }
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
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
    
    
    @objc private func handleLoginRequest() {
        viewModel.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        
    }
    
    @objc func handleSignUp() {
        let vc = RegisterController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
