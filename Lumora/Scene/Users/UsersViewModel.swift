//
//  UsersViewModel.swift
//  Lumora
//
//  Created by Aynur on 22.03.26.
//

import Foundation

final class UsersViewModel {
    var users: [User] = []
    private var currentPage = 1
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    private let useCase: UsersUseCase
    
    //MARK: Search History
    private let historyKey = "searchHistory"
    var searchHistory: [String] {
        return UserDefaults.standard.stringArray(forKey: historyKey) ?? []
    }
    
    
    init(useCase: UsersUseCase) {
        self.useCase = useCase
    }
    
    //MARK: Search Users
    func searhUsers(query: String) {
        currentPage = 1
        
        addToHistory(query)
        
        useCase.searchUsers(query: query, page: currentPage) { data, errorMessage in
            if let errorMessage{
                self.error?(errorMessage)
            } else if let data {
                self.users = data
                self.currentPage += 1
                self.success?()
            }
        }
    }
    func loadMore(query: String) {
        useCase.searchUsers(query: query, page: currentPage) { data, errorMessage in
            
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.users.append(contentsOf: data)
                self.currentPage += 1
                self.success?()
            }
        }
    }
    
    // MARK: - History Management
    private func addToHistory(_ query: String) {
        var history = searchHistory
        
        // Əgər artıq varsa silirik (duplicate olmasın)
        if let index = history.firstIndex(of: query) {
            history.remove(at: index)
        }
        
        // Yeni search-i başa əlavə edirik
        history.insert(query, at: 0)
        
        // Maksimum 10 item saxlayırıq
        if history.count > 10 {
            history = Array(history.prefix(10))
        }
        
        // UserDefaults-a yazırıq
        UserDefaults.standard.set(history, forKey: historyKey)
    }
    func deleteHistoryItem(at index: Int) {
        var history = searchHistory
        history.remove(at: index)
        UserDefaults.standard.set(history, forKey: historyKey)
    }
    
    func clearHistory() {
        UserDefaults.standard.removeObject(forKey: historyKey)
    }
}
