//
//  Coordinator.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func openPhotoDetail(photo: Photo)
    
}

class AppCoordinator: Coordinator {
  
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = HomeController()
        navigationController.show(controller, sender: nil)
    }
    
    func openPhotoDetail(photo: Photo) {
        let controller = PhotoDetailController(viewModel: .init(photo: photo))
        navigationController.pushViewController(controller, animated: true)
    }
    
    
}
