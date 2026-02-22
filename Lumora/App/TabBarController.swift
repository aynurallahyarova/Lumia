//
//  TabBarController.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabbarUI()
        configureViewControllers()
    }
    private func configureViewControllers() {
        let homeController = HomeController()
        let homeNav = UINavigationController(rootViewController: homeController)
        homeNav.tabBarItem = .init(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let topicsController = TopicsController()
        let topicsNav = UINavigationController(rootViewController: topicsController)
        topicsNav.tabBarItem = .init(title: "Topics", image: UIImage(systemName: "list.bullet"), tag: 1)
        
        let usersController = UsersController()
        let usersNav = UINavigationController(rootViewController: usersController)
        usersNav.tabBarItem = .init(title: "Users", image: UIImage(systemName: "person.3.fill"), tag: 2)
        
        let favoritesController = FavoritesController()
        let favoriteNav = UINavigationController(rootViewController: favoritesController)
        favoriteNav.tabBarItem = .init(title: "Favorite", image: UIImage(systemName: "star.fill"), tag: 3)
        
        let profileController = ProfileController()
        let profileNav = UINavigationController(rootViewController: profileController)
        profileNav.tabBarItem = .init(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 4)
        
        viewControllers = [homeNav, topicsNav, usersNav, favoriteNav, profileNav]
    }
    private func configureTabbarUI() {
        tabBar.backgroundColor = .white
    }


}
