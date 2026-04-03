//
//  LoginAdapter.swift
//  Lumora
//
//  Created by Aynur on 03.04.26.
//

import Foundation
import GoogleSignIn
import AuthenticationServices

class LoginAdapter {
    var controller: UIViewController
    
    enum LoginType {
        case apple
        case facebook
        case google
        case email(String, String)
    }
    
    enum ViewState {
        case success(User)
        case failure(String)
        case loading
    }
    
    var completion: ((ViewState)-> Void)?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func login(type: LoginType, controller: UIViewController) {
        switch type {
        case .email(let email, let password):
            completion?(.loading)
            signup(email: email, password: password)
        case .apple:
            loginWithApple(controller: controller)
        case .facebook:
            loginWithFacebook()
        case .google:
            loginWithGoogle(controller: controller)
        }
    }
    private func loginWithApple(controller: UIViewController) {
        
    }
    
    private func loginWithFacebook() {
        
    }
    
    private func loginWithGoogle(controller: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { result, error in
            if let error {
//                self.failure?(error.localizedDescription)
                self.completion?(.failure(error.localizedDescription))
            } else if let result {
                let userProfile = result.user.profile
                let user: User = .init(email: userProfile?.email ?? "",
                                       fullname: userProfile?.name ?? "")
//                print(user.fullname)
//                print(user.email)
                self.completion?(.success(user))
            }
        }
    }
    
    private func signup(email: String, password: String) {
        FirebaseAdapter.shared.signUp(email: email, password: password) { error in
            if let error {
                self.completion?(.failure(error))
            } else {
                self.completion?(.success(.init(email: email, fullname: "")))
            }
        }
    }
}
