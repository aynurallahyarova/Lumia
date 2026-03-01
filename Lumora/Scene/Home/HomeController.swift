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
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        return collection
    }()
    
    private let viewModel = HomeViewModel()
    private let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureUI() {
        navigationItem.title = "Lumora"
        view.backgroundColor = .white
        searchBar.placeholder = "Search photos"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
    }
    
    override func configureViewModel() {
        viewModel.fetchPhotos()
        viewModel.success = {
            self.collection.reloadData()
        }
        viewModel.error = { error in
            print(error)
          }
    }
    override func configureConstraints() {
        view.addSubview(collection)
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collection.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        cell.configure(with: photo)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 8) / 2
        
        let photo = viewModel.photos[indexPath.item]
        
        let photoWidth = CGFloat(photo.urls?.width ?? 300)
        let photoHeight = CGFloat(photo.urls?.height ?? 300)
        
        let ratio = photoHeight / photoWidth
        let imageHeight = width * ratio
        
        let totalHeight = imageHeight + 30  
        
        return CGSize(width: width, height: totalHeight)
    }
}
extension HomeController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        viewModel.searchPhotos(query: text)
        searchBar.resignFirstResponder()
    }
}

