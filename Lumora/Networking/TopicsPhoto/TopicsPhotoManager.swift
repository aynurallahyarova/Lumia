//
//  TopicsPhotoManager.swift
//  Lumora
//
//  Created by Aynur on 22.03.26.
//

import Foundation

class TopicsPhotoManager: TopicsPhotoUseCase {
    private let manager = CoreManager()
    
    func fetchTopicPhotos(topicId: String, page: Int, completion: @escaping ([Photo]?, String?) -> Void) {
        manager.request(model: [Photo].self, endpoint: TopicsPhotoEndpoint.photos(topicID: topicId, page: page).path, completion: completion)
    }
}
