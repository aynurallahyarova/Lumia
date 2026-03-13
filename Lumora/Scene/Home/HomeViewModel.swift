//
//  HomeViewModel.swift
//  Lumora
//
//  Created by Aynur on 24.02.26.
//

import UIKit

final class HomeViewModel {
    
    var photos: [Photo] = []
    private var currentPage = 1
    var success: (() -> Void)?
    var error: ((String) -> Void)?

    private let useCase: HomeUseCase
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    func fetchPhotos() {
        useCase.fetchPhotos(page: currentPage, perPage: 30) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.photos.append(contentsOf: data)
                self.currentPage += 1
                self.success?()
            }
        }
    }
    
    func searchPhotos(query: String) {
        useCase.searchPhotos(query: query) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.photos = data
                self.success?()
            }
        }
    }
}
