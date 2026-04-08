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
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = doc?.data() else {
                completion(nil)
                return
            }
            
            // Profil sekli ucun data yoxlamasi
            let profileDict = data["profile_image"] as? [String: String]
            
            // Əgər profil yoxdusa defaultu bos qoyuruq
            let profile = ProfileImage(
                small: profileDict?["small"] ?? "",
                medium: profileDict?["medium"] ?? ""
            )
            
            // melumatlari cekirik
            let fullname = data["fullname"] as? String
            let email = data["email"] as? String
            let username = data["username"] as? String
            
            let user = User(
                id: data["id"] as? String,
                username: (username == nil || username!.isEmpty) ? "new_user" : username,
                name: data["name"] as? String,
                profileImage: profile,
                email: (email == nil || email!.isEmpty) ? "No Email Provided" : email,
                fullname: (fullname == nil || fullname!.isEmpty) ? "Guest User" : fullname
            )
            completion(user)
        }
    }
}
