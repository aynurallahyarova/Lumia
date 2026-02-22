//
//  BaseController.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModel()
        configureConstraints()
    }
    func configureUI() {}
    
    func configureViewModel() {}
    
    func configureConstraints() {}

}
