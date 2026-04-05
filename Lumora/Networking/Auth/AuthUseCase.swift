//
//  AuthUseCase.swift
//  Lumora
//
//  Created by Aynur on 06.04.26.
//

import Foundation
final class AuthUseCase {
    
    func register(email: String, password: String, fullname: String, username: String, completion: @escaping (String?) -> Void) {
        AuthManager.shared.register(email: email, password: password) { error, uid in
            if error != nil {
                completion(error)
                return
            }
            
            let user = User(
                id: uid,
                username: username,
                name: fullname,
                profileImage: nil,
                email: email,
                fullname: fullname
            )
            
            UserManager.shared.saveUser(user: user) { error in
                completion(error)
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (String?) -> Void) {
        AuthManager.shared.login(email: email, password: password, completion: completion)
    }
    
    func getProfile(completion: @escaping (User?) -> Void) {
        let id = AuthManager.shared.getUserId()
        
        if id == nil {
            completion(nil)
            return
        }
        UserManager.shared.getUser(id: id!, completion: completion)
    }
}
