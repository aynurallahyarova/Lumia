//
//  ProfileController.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

class ProfileController: UIViewController {

    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onUser = { user in
            print(user.username ?? "")
            print(user.profileImage?.medium ?? "")
        }
        viewModel.loadUser()
    }



}
