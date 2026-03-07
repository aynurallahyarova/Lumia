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
        let viewModel = TopicsViewModel()
        let controller = TopicsController()
        navigationController.pushViewController(controller, animated: false)
    }
    
    
}
