//
//  LoginViewModel.swift
//  Lumora
//
//  Created by Aynur on 03.04.26.
//

import Foundation

final class LoginViewModel {
    let useCase = AuthUseCase()
    var success: (() -> Void)?
    var error: (() -> Void)?
    
    func login(email: String, password: String) {
        useCase.login(email: email, password: password) { error in
            if error != nil {
                self.error?()
            } else {
                self.success?()
            }
        }
    }
}
