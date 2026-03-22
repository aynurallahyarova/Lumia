//
//  TopicsPhotoViewModel.swift
//  Lumora
//
//  Created by Aynur on 22.03.26.
//

import Foundation

final class TopicsPhotoViewModel {
    
    private let useCase: TopicsPhotoUseCase
    var photos: [Photo] = []
    private var currentPage = 1
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    init(useCase: TopicsPhotoUseCase){
        self.useCase = useCase
    }
    
    func fetchPhotos(topicId: String) {
        useCase.fetchTopicPhotos(topicId: topicId, page: currentPage) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.photos.append(contentsOf: data)
                self.currentPage += 1
                self.success?()
            }
        }
    }
    
    func reset() {
        photos.removeAll(); currentPage = 1 
    }
    
}
