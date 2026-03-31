//
//  UsersController.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

class UsersController: BaseController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(UsersCell.self, forCellReuseIdentifier: UsersCell.identifier)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController()
        sc.searchBar.placeholder = "Search members"
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.delegate = self

        return sc
    }()
    
    private lazy var searchBar: UISearchBar = searchController.searchBar
    
    private var currentQuery = "Aynur"
    
    private var isShowingHistory = false
    
    private let viewModel = UsersViewModel(useCase: UsersManager())
    
    var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.searhUsers(query: currentQuery)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    override func configureUI() {
        view.backgroundColor = .white
        title = "Users"
        setupNavigationItems()
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func configureViewModel() {
        viewModel.success = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.error = { error in
            print(error)
        }
    }
    
    private func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(menuTapped))
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .black

        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageView.layer.cornerRadius = 20
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit

        imageView.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        imageView.addGestureRecognizer(tap)

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)
    }
    @objc private func menuTapped() {
        print("menu tapped")
    }

    @objc private func profileTapped() {
//        coordinator?.openProfile()
    }
}

extension UsersController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isShowingHistory ? viewModel.searchHistory.count : viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isShowingHistory {
            // HISTORY CELL
            let cell = UITableViewCell(style: .default, reuseIdentifier: "historyCell")
            
            cell.textLabel?.text = viewModel.searchHistory[indexPath.row]
            
            return cell
            
        } else {
            // NORMAL USER CELL
            let cell = tableView.dequeueReusableCell(withIdentifier: UsersCell.identifier, for: indexPath) as! UsersCell
            
            let user = viewModel.users[indexPath.row]
            cell.configure(user: user)
            
            return cell
        }
    }
    // Swipe ilə silmək
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if isShowingHistory && editingStyle == .delete {
            
            viewModel.deleteHistoryItem(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension UsersController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isShowingHistory = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isShowingHistory = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        isShowingHistory = false
        
        currentQuery = text
        
        viewModel.users.removeAll()
        tableView.reloadData()
        
        // API + HISTORY SAVE
        viewModel.searhUsers(query: text)
        
        searchBar.resignFirstResponder()
    }
}
extension UsersController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isShowingHistory {
            
            // History-dən seçəndə
            let query = viewModel.searchHistory[indexPath.row]
            
            searchController.searchBar.text = query
            
            isShowingHistory = false
            
            viewModel.users.removeAll()
            tableView.reloadData()
            
            viewModel.searhUsers(query: query)
            
        } else {
            let selectedUser = viewModel.users[indexPath.row]
            coordinator?.openUserDetail(user: selectedUser)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isShowingHistory else { return }
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - scrollView.frame.size.height - 100) {
            viewModel.loadMore(query: currentQuery)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.item]
        coordinator?.openUserDetail(user: user)
    }

}

