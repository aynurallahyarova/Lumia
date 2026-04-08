//
//  ProfileController.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

class ProfileController: BaseController {
    
    private lazy var menuStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 60
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "person.crop.circle")
        iv.backgroundColor = .systemGray6
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Aynur Allahyarova"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "aynurallahyarova@gmail.com"
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 25
        
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        }()

    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadUser()
    }
    
    override func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(menuStackView)
        view.addSubview(logoutButton)
        
        let accountBtn = createMenuButton(iconName: "person.fill", title: "Account", tag: 0)
        let languageBtn = createMenuButton(iconName: "globe", title: "Language", tag: 1)
        let aboutBtn = createMenuButton(iconName: "info.circle.fill", title: "About", tag: 2)
        let termsBtn = createMenuButton(iconName: "doc.text.fill", title: "Terms and Conditions", tag: 3)
        
        [accountBtn, languageBtn, aboutBtn, termsBtn].forEach { menuStackView.addArrangedSubview($0) }
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            menuStackView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30),
            menuStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            menuStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            logoutButton.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor,constant: -60),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 220),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    override func configureViewModel() {
        viewModel.onUser = { [weak self] user in
            guard let self = self else { return }
            
            self.nameLabel.text = user.fullname ?? "Guest User"
            self.emailLabel.text = user.email ?? "noemail@example.com"
            
            // sekil yoxlanmasi
            if let imageUrl = user.profileImage?.medium, !imageUrl.isEmpty {
                self.profileImageView.loadURL(data: imageUrl)
            } else {
                self.profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
                self.profileImageView.tintColor = .systemGray4
            }
        }
    }
    
    @objc private func logoutTapped() {
        AuthManager.shared.logout()
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let loginVC = LoginController()
            let nav = UINavigationController(rootViewController: loginVC)
            
            sceneDelegate.window?.rootViewController = nav
        }
    }
    
    private func createMenuButton(iconName: String, title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = tag
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.addTarget(self, action: #selector(menuItemTapped(_:)), for: .touchUpInside)
        
        // İkonun arxa fonu (Dairəvi)
        let iconContainer = UIView()
        iconContainer.backgroundColor = .systemGray6
        iconContainer.layer.cornerRadius = 20
        iconContainer.isUserInteractionEnabled = false // Klik düyməyə keçsin
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView(image: UIImage(systemName: iconName))
        iconImageView.tintColor = .systemBlue
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = .lightGray
        chevron.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        button.addSubview(label)
        button.addSubview(chevron)
        
        NSLayoutConstraint.activate([
            iconContainer.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10),
            iconContainer.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 40),
            iconContainer.heightAnchor.constraint(equalToConstant: 40),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            label.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 15),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            chevron.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
            chevron.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            chevron.widthAnchor.constraint(equalToConstant: 12),
            chevron.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return button
    }
    
    @objc private func menuItemTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0: print("Account")
        case 1: print("Language")
        case 2: print("About")
        case 3: print("Terms")
        default: break
        }
    }
}
