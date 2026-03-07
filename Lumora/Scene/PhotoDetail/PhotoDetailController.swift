//
//  PhotoDetailController.swift
//  Lumora
//
//  Created by Aynur on 07.03.26.
//

import UIKit

class PhotoDetailController: BaseController {
    
    var photo: Photo?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let button: UIButton = {
        let b = UIButton()
        return b
    }()

    private let userLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func configureUI() {
        view.backgroundColor = .white
    }
    override func configureConstraints() {
        view.addSubview(imageView)
        view.addSubview(userLabel)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    override func configureViewModel() {
        <#code#>
    }
    

}
