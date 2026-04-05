//
//  FirebaseAdapter.swift
//  Lumora
//
//  Created by Aynur on 03.04.26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol FirebaseAdapterUseCase {
    func signUp(email: String, password: String, completion: @escaping (String?) -> Void)
    func signIn(email: String, password: String)
    func signOut()
}

final class FirebaseAdapter: FirebaseAdapterUseCase {

    
    static let shared = FirebaseAdapter()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    func signUp(email: String, password: String, completion: @escaping(String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                completion(error.localizedDescription)
            } else if let result {
                UserDefaults.standard.set(result.user.uid, forKey: "userId")
                self.saveUserInfoToFirestore(email: email, password: password, completion: completion)
                completion(nil)
            }
        }
    }
    func signIn(email: String, password: String) {
        
    }
    
    func signOut() {
        
    }
    private func saveUserInfoToFirestore(email: String, password: String, completion: @escaping(String?) -> Void) {
        db.collection("users").addDocument(data: ["birthdate": "", "email": email, "password": password]) {
            error in
            if let error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
}

