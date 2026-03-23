//
//  UsersController.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

class UsersController: BaseController {
    
    private let tableView = UITableView()
    private let searchController = UISearchController()
    
    private var currentQuery = "Aynur"
    
    private let viewModel = UsersViewModel(useCase: UsersManager())
    
    private let searchBar = UISearchBar()
    var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.searhUsers(query: currentQuery)

    }
    override func configureUI() {
        view.backgroundColor = .white
        title = "Users"
        
        setupNavigationItems()
        
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search members"
        
        searchController.searchBar.delegate = self
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.register(UsersCell.self, forCellReuseIdentifier: UsersCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func configureViewModel() {
        viewModel.success = {
            self.tableView.reloadData()
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
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: UsersCell.identifier, for: indexPath) as! UsersCell
        
        let user = viewModel.users[indexPath.row]
        cell.configure(user: user)
        
        return cell
    }
}

extension UsersController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        viewModel.users.removeAll()
        tableView.reloadData()
        viewModel.searhUsers(query: text)
        searchBar.resignFirstResponder()
    }
}
extension UsersController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > (tableView.contentSize.height - scrollView.frame.size.height - 100) {
            viewModel.loadMore(query: currentQuery)
        }
    }
}
