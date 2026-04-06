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
    var error: ((String) -> Void)?
    
    func login(email: String, password: String) {
        useCase.login(email: email, password: password) { error in
            if let error = error {
                self.error?(error)
            } else {
                self.success?()
            }
        }
    }
    
    func register(email: String, password: String, fullName: String) {
        useCase.register(email: email, password: password, fullname: fullName, username: fullName) { error in
            if let error = error {
                self.error?(error)
            } else {
                self.success?()
            }
        }
        
    }
}
