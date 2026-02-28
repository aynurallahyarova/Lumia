//
//  HomeController.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

class HomeController: BaseController {
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
        return collection
    }()
    
    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureUI() {
        navigationItem.title = "Lumora"
        view.backgroundColor = .white
    }
    
    override func configureViewModel() {
        viewModel.fetchPhotos()
        viewModel.success = {
            self.collection.reloadData()
        }
    }
    override func configureConstraints() {
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
extension HomeController: CollectionConfiguration {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        let photo = viewModel.photos[indexPath.item]
        cell.
        return cell
    }
}
extension HomeController: UICollectionViewFlowLayout {
    
}
