//
//  AuthManager.swift
//  Lumora
//
//  Created by Aynur on 04.04.26.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    static let shared = AuthManager()
    
    func register(email: String, password: String, completion: @escaping (String?, String?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                completion("Error", nil)
                return
            }
            
            let uid = result?.user.uid
            
            if uid != nil {
                completion(nil, uid)
            } else {
                completion("No user", nil)
            }
        }
    }
    //LOGIN
    func login(email: String, password: String, completion: @escaping (String?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                completion("Login error")
            } else {
                completion(nil)
            }
        }
    }
    
    func getUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}
