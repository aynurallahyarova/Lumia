//
//  HomeManager.swift
//  Lumora
//
//  Created by Aynur on 13.03.26.
//

import Foundation

class HomeManager: HomeUseCase {
    private let manager = CoreManager()
    
    func fetchPhotos(page: Int, perPage: Int = 30 , completion: @escaping ([Photo]?, String?) -> Void) {
        manager.request(model: [Photo].self, endpoint: PhotoEndpoint.photos.rawValue,parameters: ["page": page, "per_page": perPage], completion: completion)
    }
    
    func searchPhotos(query: String, completion: @escaping ([Photo]?, String?) -> Void) {
        manager.request(model: SearchPhotoResponse.self, endpoint: PhotoEndpoint.searchPhotos.rawValue,   parameters: ["query": query]
        ) { data, errorMessage in
            if let errorMessage {
                completion(nil, errorMessage)
            } else if let data {
                completion(data.results, nil)
            }
        }
    }
}
    

    
    
    
}
