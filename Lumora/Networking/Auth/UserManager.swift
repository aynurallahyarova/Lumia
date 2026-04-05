//
//  UserManager.swift
//  Lumora
//
//  Created by Aynur on 05.04.26.
//

import Foundation
import FirebaseFirestore

final class UserManager {
    
    static let shared = UserManager()
    let db = Firestore.firestore()
    
    func saveUser(user: User, completion: @escaping (String?) -> Void) {
        let id = user.id ?? ""
        let email = user.email ?? ""
        let fullname = user.fullname ?? ""
        let username = user.username ?? ""
        let name = user.name ?? ""
        
        let small = user.profileImage?.small ?? ""
        let medium = user.profileImage?.medium ?? ""
        
        let profileImage: [String: Any] = [
            "small": small,
            "medium": medium
        ]
        
        let data: [String: Any] = [
            "id": id,
            "email": email,
            "fullname": fullname,
            "username": username,
            "name": name,
            "profile_image": profileImage
        ]
        
        db.collection("users").document(id).setData(data) { error in
            
            if error != nil {
                completion("Save error")
            } else {
                completion(nil)
            }
        }
    }
    //USER FETCH profil ucun

    func getUser(id: String, completion: @escaping (User?) -> Void) {
        
        db.collection("users").document(id).getDocument { doc, error in
            if error != nil {
                completion(nil)
                return
            }
            
            let data = doc?.data()
            
            let profileDict = data?["profile_image"] as? [String: String]
            
            let profile = ProfileImage(
                small: profileDict?["small"],
                medium: profileDict?["medium"]
            )
            
            let user = User(
                id: data?["id"] as? String,
                username: data?["username"] as? String,
                name: data?["name"] as? String,
                profileImage: profile,
                email: data?["email"] as? String,
                fullname: data?["fullname"] as? String
            )
            
            completion(user)
        }
    }
}
