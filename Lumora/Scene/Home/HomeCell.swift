//
//  HomeCell.swift
//  Lumora
//
//  Created by Aynur on 24.02.26.
//

import UIKit

class HomeCell: UICollectionViewCell {
    static let identifier = "HomeCell"
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var isFavorite = false
    private var photo: Photo?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
        configureUI()
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteUpdate), name: NSNotification.Name("FavoriteUpdated"), object: nil)
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.alpha = 1.0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureUI() {
        contentView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
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
        self.photo = photo
    }
    
    @objc private func handleFavoriteUpdate() {
        guard let photoId = photo?.id else { return }
        FavoriteManager.shared.isFavorite(photoId: photoId) { [weak self] favorite in
            DispatchQueue.main.async {
                self?.isFavorite = favorite
                let imageName = favorite ? "heart.fill" : "heart"
                self?.favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
                self?.favoriteButton.tintColor = favorite ? .red : .white
            }
        }
    }
    
    @objc private func favoriteTapped() {
        guard let photo = photo else { return }
        
        isFavorite.toggle()
        
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = isFavorite ? .red : .white

        if isFavorite {
            FavoriteManager.shared.addFavorite(photo: photo) { error in
                if let error = error {
                    print(error)
                } else {
                    print("Added")
                }
            }
        } else {
            FavoriteManager.shared.removeFavorite(photoId: photo.id ?? "") { error in
                if let error = error {
                    print(error)
                } else {
                    print("Removed")
                }
            }
        }
    }
}

