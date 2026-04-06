//
//  PhotoDetailController.swift
//  Lumora
//
//  Created by Aynur on 07.03.26.
//

import UIKit

class PhotoDetailController: BaseController {
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let userLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .semibold)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var button: UIButton = {
        let b = UIButton()
        b.setTitle("Download", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .black
        b.layer.cornerRadius = 18
        b.addTarget(self, action: #selector(downloadTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var viewModel: PhotoDetailViewModel
    private var isFavorite = false
    
    init(viewModel: PhotoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func configureUI() {
        view.backgroundColor = .white
        backgroundImageView.loadURL(data: viewModel.imageURL)
        userLabel.text = viewModel.userName
        imageView.loadURL(data: viewModel.imageURL)
    }
    
    override func configureViewModel() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(favoriteTapped)
        )
    }

    
    override func configureConstraints() {
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(blurView)
        view.addSubview(userLabel)
        view.addSubview(imageView)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            blurView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            userLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            imageView.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 350),

            button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func favoriteTapped() {
        isFavorite.toggle()
        
        let imageName = isFavorite ? "heart.fill" : "heart"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
        navigationItem.rightBarButtonItem?.tintColor = isFavorite ? .red: .black
    }
    
    @objc private func downloadTapped() {
        let alert = UIAlertController(title: "Download Image", message: "Choose size", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Small", style: .default, handler: { _ in
            self.downloadAndShowAlert(url: self.viewModel.smallImageURL)
        }))
        
        alert.addAction(UIAlertAction(title: "Regular", style: .default, handler: { _ in
            self.downloadAndShowAlert(url: self.viewModel.imageURL)
        }))
        
        alert.addAction(UIAlertAction(title: "Full", style: .default, handler: { _ in
            self.downloadAndShowAlert(url: self.viewModel.fullImageURL)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func downloadAndShowAlert(url: String) {
        imageView.downloadImage(from: url) {
            DispatchQueue.main.async {
                self.showSuccessAlert()
            }
        }
    }
    
    private func showSuccessAlert() {
        let alert = UIAlertController(
            title: "Saved",
            message: "Image saved to gallery",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
