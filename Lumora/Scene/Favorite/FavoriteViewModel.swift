//
//  FavoriteViewModel.swift
//  Lumora
//
//  Created by Aynur on 07.04.26.
//

import Foundation

final class FavoriteViewModel {
    var items: [FavoriteModel] = []
    
    var photos: [Photo] {
            return items.map { item in
                let photoUrls = PhotoUrls(small: item.imageUrl, regular: item.imageUrl, full: nil, width: nil, height: nil)
                let photoUser = PhotoUser(id: nil, name: item.username, username: item.username)
                
                return Photo(
                    id: item.id,
                    description: nil,
                    altDescription: nil,
                    urls: photoUrls,
                    user: photoUser
                )
            }
        }
    
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    
    // melumatlari firestoredan yukleyirik
    func getFavorites() {
        FavoriteManager.shared.getFavorites { [weak self] favorites in
        self?.items = favorites
        self?.onSuccess?()
        }
    }
    
    func removeItem(at index: Int) {
        let photoId = items[index].id
        FavoriteManager.shared.removeFavorite(photoId: photoId) { [weak self] error in
            if let error = error {
                self?.onError?(error)
            } else {
                self?.items.remove(at: index)
                self?.onSuccess?()
            }
        }
    }
    
    func addItem(_ favorite: FavoriteModel) {
        items.append(favorite)
        onSuccess?()
    }
}
