//
//  HomeCell.swift
//  Lumora
//
//  Created by Aynur on 24.02.26.
//

import UIKit

class HomeCell: UICollectionViewCell {
    static let identifier = "HomeCell"
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let favoriteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureUI() {
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = .systemFont(ofSize: 12)
        nameLabel.numberOfLines = 1
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .white
        favoriteButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        favoriteButton.layer.cornerRadius = 14
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
    
        
    }
    func configureConstraints() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        imageView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 28),
            favoriteButton.heightAnchor.constraint(equalToConstant: 28),
            favoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            favoriteButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8)
        ])
    }
    
    
    func configure(with photo: Photo) {
        imageView.loadURL(data: photo.urls?.small ?? "")
        nameLabel.text = photo.user?.name
        
    }
}
