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
    
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = HomeController()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: false)
    }
    func openPhotoDetail(photo: Photo) {
        let controller = PhotoDetailController()
        controller.viewModel = PhotoDetailViewModel(photo: photo)
        navigationController.pushViewController(controller, animated: true)
    }
    
    
}
