//
//  FavoriteManager.swift
//  Lumora
//
//  Created by Aynur on 07.04.26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class FavoriteManager {
    static let shared = FavoriteManager()
    private let db = Firestore.firestore()
    
    private var userId: String? {
        return Auth.auth().currentUser?.uid
    }
    
    // ADD FAVORITE
    func addFavorite(photo: Photo, completion: @escaping (String?) -> Void) {
        guard let uid = userId,
              let photoId = photo.id else {
            completion("No user")
            return
        }
        
        let data: [String: Any] = [
            "id": photoId,
            "imageUrl": photo.urls?.regular ?? "",
            "username": photo.user?.name ?? "",
            "createdAt": Timestamp()
        ]
        
        db.collection("users")
            .document(uid)
            .collection("favorites")
            .document(photoId)
            .setData(data) { error in
                
                if error != nil {
                    completion("Favorite save error")
                } else {
                    completion(nil)
                }
            }
    }
    
    // REMOVE FAVORITE
    func removeFavorite(photoId: String, completion: @escaping (String?) -> Void) {
        guard let uid = userId else {
            completion("No user")
            return
        }
        
        db.collection("users")
            .document(uid)
            .collection("favorites")
            .document(photoId)
            .delete { error in
                
                if error != nil {
                    completion("Delete error")
                } else {
                    completion(nil)
                }
            }
    }
    
    // GET FAVORITES
    func getFavorites(completion: @escaping ([FavoriteModel]) -> Void) {
        guard let uid = userId else {
            completion([])
            return
        }
        
        db.collection("users")
            .document(uid)
            .collection("favorites")
            .getDocuments { snapshot, error in
                
                var items: [FavoriteModel] = []
                
                snapshot?.documents.forEach { doc in
                    let data = doc.data()
                    
                    let item = FavoriteModel(
                        id: data["id"] as? String ?? "",
                        imageUrl: data["imageUrl"] as? String ?? "",
                        username: data["username"] as? String ?? ""
                    )
                    items.append(item)
                }
                completion(items)
            }
    }
}
