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

    private(set) var useCase: HomeUseCase
    
    // MARK: - History
    private let historyKey = "homeSearchHistory"
    
    // UserDefaults-dan oxuyuruq
    var searchHistory: [String] {
        return UserDefaults.standard.stringArray(forKey: historyKey) ?? []
    }
    
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
        addToHistory(query)
        
        useCase.searchPhotos(query: query) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.photos = data
                self.success?()
            }
        }
    }
    // MARK: - History əlavə
    private func addToHistory(_ query: String) {
        var history = searchHistory
        
        // duplicate varsa sil
        if let index = history.firstIndex(of: query) {
            history.remove(at: index)
        }
        
        // yeni query başa əlavə olunur
        history.insert(query, at: 0)
        
        // max 10
        if history.count > 10 {
            history = Array(history.prefix(10))
        }
        
        // yadda saxla
        UserDefaults.standard.set(history, forKey: historyKey)
    }
    
    // MARK: - Silmək (swipe)
    func deleteHistoryItem(at index: Int) {
        var history = searchHistory
        history.remove(at: index)
        UserDefaults.standard.set(history, forKey: historyKey)
    }
}
