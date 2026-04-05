//
//  ProfileViewModel.swift
//  Lumora
//
//  Created by Aynur on 06.04.26.
//

import Foundation

final class ProfileViewModel {
    let useCase = AuthUseCase()
    
    var onUser: ((User) -> Void)?
    
    func loadUser() {
        useCase.getProfile { user in
            if user != nil {
                self.onUser?(user!)
            }
        }
    }
}
