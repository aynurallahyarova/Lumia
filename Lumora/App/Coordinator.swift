//
//  Coordinator.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
    func openPhotoDetail(photo: Photo)
    
}

class AppCoordinator: Coordinator {
  
    var navigationController: UINavigationController
    

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let tabBar = TabBarController()
//        tabBar.coordinator = self
//        navigationController.setViewControllers([tabBar], animated: false)
        let homeController = HomeController()
        homeController.coordinator = self
        let homeNav = UINavigationController(rootViewController: homeController)
        homeNav.tabBarItem = .init(title: "Home", image: UIImage(systemName: "square.grid.2x2"), tag: 0)
        
        let topicsController = TopicsController()
        let topicsNav = UINavigationController(rootViewController: topicsController)
        topicsNav.tabBarItem = .init(title: "Topics", image: UIImage(systemName: "line.3.horizontal.decrease.circle"), tag: 1)
        
        let usersController = UsersController()
        let usersNav = UINavigationController(rootViewController: usersController)
        usersNav.tabBarItem = .init(title: "Users", image: UIImage(systemName: "person.3.sequence"), tag: 2)
        
        let favoritesController = FavoritesController()
        let favoriteNav = UINavigationController(rootViewController: favoritesController)
        favoriteNav.tabBarItem = .init(title: "Favorite", image: UIImage(systemName: "heart"), tag: 3)
        
        let profileController = ProfileController()
        let profileNav = UINavigationController(rootViewController: profileController)
        profileNav.tabBarItem = .init(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 4)
        let tabBar = UITabBarController()
        tabBar.viewControllers = [homeNav, topicsNav, usersNav, favoriteNav, profileNav]

        navigationController.setViewControllers([tabBar], animated: false)
        navigationController.isNavigationBarHidden = true
        
    }
    
    func openPhotoDetail(photo: Photo) {
        let controller = PhotoDetailController(viewModel: .init(photo: photo))
        navigationController.pushViewController(controller, animated: true)
    }
}
