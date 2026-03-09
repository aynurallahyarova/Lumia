//
//  PhotoDetailController.swift
//  Lumora
//
//  Created by Aynur on 07.03.26.
//

import UIKit

class PhotoDetailController: BaseController {
    
    var photo: Photo?
    var viewModel: PhotoDetailViewModel?
    
    private let imageView: UIImageView = {
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

    private let button: UIButton = {
        let b = UIButton()
        b.setTitle("Download", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .black
        b.layer.cornerRadius = 18
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func configureUI() {
        view.backgroundColor = .white
    }
    override func configureConstraints() {
        view.addSubview(userLabel)
        view.addSubview(imageView)
        view.addSubview(button)

        NSLayoutConstraint.activate([
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
    override func configureViewModel() {
        userLabel.text = viewModel?.userName
        if let url = viewModel?.imageURL {
            imageView.loadURL(data: url)
        }
    }
    

}
