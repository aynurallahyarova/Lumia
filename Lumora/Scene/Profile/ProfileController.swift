//
//  ProfileController.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

class ProfileController: BaseController {
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 60
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemGray6
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
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
        view.addSubview(logoutButton)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            // Ad dərhal şəklin altında
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Email adın altında
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Log Out düyməsi ən aşağıda (Safe Area-dan yuxarıda)
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 220),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    override func configureViewModel() {
        viewModel.onUser = { [weak self] user in
            guard let self = self else { return }
            self.nameLabel.text = user.fullname
            self.emailLabel.text = user.email
            self.profileImageView.loadURL(data: user.profileImage?.medium ?? "")
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


}
