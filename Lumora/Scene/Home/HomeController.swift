//
//  HomeController.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

class HomeController: BaseController {
    private lazy var collection: UICollectionView = {
        let layout = WaterfallLayout()
        layout.delegate = self
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.headerHeight = 8.0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        return collection
    }()
    
    private lazy var historyTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "history")
        table.isHidden = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Search photos"
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.delegate = self
        return sc
    }()
    
    private lazy var homeManager = HomeManager()
    private lazy var viewModel = HomeViewModel(useCase: homeManager)

    var coordinator: AppCoordinator?
    //  history göstərmək üçün
    private var isShowingHistory = false

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureUI() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Lumora"
        view.backgroundColor = .white
        navigationItem.searchController = searchController
    }
    
    override func configureViewModel() {
        viewModel.fetchPhotos()
        viewModel.success = { [weak self] in
            self?.collection.reloadData()
        }
        viewModel.error = { error in
            print(error)
        }
    }
    override func configureConstraints() {
        historyTable.frame = view.bounds
        view.addSubview(collection)
        view.addSubview(historyTable)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
        let photo = viewModel.photos[indexPath.item]
        cell.configure(with: photo)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        let photo = viewModel.photos[indexPath.item]
        coordinator?.openPhotoDetail(photo: photo)
    }
}
extension HomeController: UITableViewDataSource, UITableViewDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isShowingHistory = false
            historyTable.isHidden = true
            collection.isHidden = false
        }
//        historyTable.isHidden = searchText.isEmpty
//        collection.isHidden = !searchText.isEmpty
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: "history")
        cell.textLabel?.text = viewModel.searchHistory[indexPath.row]
        return cell
    }
    
    // swipe ilə silmək
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            viewModel.deleteHistoryItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // history seçəndə
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let query = viewModel.searchHistory[indexPath.row]
        
        searchController.searchBar.text = query
        
        isShowingHistory = false
        
        historyTable.isHidden = true
        collection.isHidden = false
        
        viewModel.photos.removeAll()
        collection.reloadData()
        
        viewModel.searchPhotos(query: query)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard !isShowingHistory else { return }
        
        let position = scrollView.contentOffset.y
        
        if position > (collection.contentSize.height - scrollView.frame.size.height - 100) {
            guard !isShowingHistory,
                  searchController.searchBar.text?.isEmpty ?? true
            else { return }
        }
    }
}
extension HomeController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isShowingHistory = true
        historyTable.isHidden = false
        collection.isHidden = true
        historyTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isShowingHistory = false
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        historyTable.isHidden = true
        collection.isHidden = false
        viewModel.photos.removeAll()
        collection.reloadData()
        viewModel.fetchPhotos()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        isShowingHistory = false
        
        historyTable.isHidden = true
        collection.isHidden = false
        
        viewModel.photos.removeAll()
        collection.reloadData()
        
        viewModel.searchPhotos(query: text)
        
        searchBar.resignFirstResponder()
    }
}

extension HomeController: WaterfallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 8) / 2
        
        let photo = viewModel.photos[indexPath.item]
        
        let photoWidth = CGFloat(photo.urls?.width ?? 300)
        let photoHeight = CGFloat(photo.urls?.height ?? 300)
        
        let ratio = photoHeight / photoWidth
        let imageHeight = width * ratio
        
        let totalHeight = imageHeight + 50
        
        return CGSize(width: width, height: indexPath.item % 2 == 0 ? totalHeight : imageHeight)
    }

    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {
//        .waterfall(column: 2, distributionMethod: .balanced)
        .waterfall(column: 2, distributionMethod: .balanced)
    }
}
