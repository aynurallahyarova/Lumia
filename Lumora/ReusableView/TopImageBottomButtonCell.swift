//
//  TopImageBottomButtonCell.swift
//  Lumora
//
//  Created by Aynur on 07.03.26.
//

import UIKit

protocol TopImageBottomLabelProtocol {
    var titleText: String { get }
    var imageName: String { get }
}

class TopImageBottomButtonCell: UICollectionViewCell {
    static let identifier = "TopImageBottomLabelCell"
    
    lazy var topImage: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = .systemFont(ofSize: 16, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        
        contentView.addSubview(topImage)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            topImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            topImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
    func configure(data: TopImageBottomLabelProtocol) {
        titleLabel.text = data.titleText
        topImage.loadURL(data: data.imageName)
    }
}
