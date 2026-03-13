//
//  HomeViewModel.swift
//  Lumora
//
//  Created by Aynur on 24.02.26.
//

import UIKit

final class HomeViewModel {
    
    var photos: [Photo] = []
    var success: (() -> Void)?
    var error: ((String) -> Void)?

    
    private let useCase: HomeUseCase
    
    
    func fetchPhotos() {
        manager.request(model: [Photo].self, endpoint: PhotoEndpoint.photos.rawValue, parameters: ["page": 1, "per_page": 30]) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.photos = data
                self.success?()
            }
        }
    }
    func searchPhotos(query: String) {
        manager.request(model: SearchPhotoResponse.self, endpoint: PhotoEndpoint.searchPhotos.rawValue, parameters: ["query": query]) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.photos = data.results
                self.success?()
            }
        }
        
    }

}
