//
//  Coordinator.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

protocol Coordinator {
//    var navigationController: UINavigationController { get set }
    func start()
    func openPhotoDetail(photo: Photo)
    func openTopicPhotos(topic: Topic)
    func openUserDetail(user: User)
}

class AppCoordinator: Coordinator {
    private let tabBarController: UITabBarController
    

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let homeController = HomeController()
        homeController.coordinator = self
        let homeNav = UINavigationController(rootViewController: homeController)
        
//        let topicsPhotoController = TopicsPhotoController(topic: Topic)
//        topicsPhotoController.coordinator = self
//        
        
        let topicsController = TopicsController()
        topicsController.coordinator = self
        let topicsNav = UINavigationController(rootViewController: topicsController)
        
        let usersController = UsersController()
        usersController.coordinator = self
        let usersNav = UINavigationController(rootViewController: usersController)
        
        let favoriteNav = UINavigationController(rootViewController: FavoritesController())
        let profileNav = UINavigationController(rootViewController: ProfileController())

        homeNav.tabBarItem = .init(title: "Home", image: UIImage(systemName: "square.grid.2x2"), tag: 0)
        topicsNav.tabBarItem = .init(title: "Topics", image: UIImage(systemName: "line.3.horizontal.decrease.circle"), tag: 1)
        usersNav.tabBarItem = .init(title: "Users", image: UIImage(systemName: "person.3.sequence"), tag: 2)
        favoriteNav.tabBarItem = .init(title: "Favorite", image: UIImage(systemName: "heart"), tag: 3)
        profileNav.tabBarItem = .init(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 4)

        tabBarController.viewControllers = [homeNav, topicsNav, usersNav, favoriteNav, profileNav]
    }
    
    
    func openPhotoDetail(photo: Photo) {
        let controller = PhotoDetailController(viewModel: .init(photo: photo))
        
        if let nav = tabBarController.selectedViewController as? UINavigationController {
            nav.pushViewController(controller, animated: true)
        }
    }
    
    func openTopicPhotos(topic: Topic) {
        let controller = TopicsPhotoController(topic: topic)
        controller.coordinator = self
        if let nav = tabBarController.selectedViewController as? UINavigationController {
            nav.pushViewController(controller, animated: true)
        }
    }
    
    func openUserDetail(user: User) {
        let controller = UserDetailController(viewModel: .init(useCase: UserDetailManager(), user: user))
        controller.coordinator = self
        if let nav = tabBarController.selectedViewController as? UINavigationController {
            nav.pushViewController(controller, animated: true)
        }
    }
}

