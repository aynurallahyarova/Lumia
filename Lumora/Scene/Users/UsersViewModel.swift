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
    
    init(useCase: UsersUseCase) {
        self.useCase = useCase
    }
    
    func searhUsers(query: String) {
        currentPage = 1
        
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
}
