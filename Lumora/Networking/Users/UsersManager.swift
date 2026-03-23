//
//  UsersManager.swift
//  Lumora
//
//  Created by Aynur on 22.03.26.
//

import Foundation

class UsersManager: UsersUseCase {
    
    private let manager = CoreManager()
    
    func searchUsers(query: String, page: Int, completion: @escaping ([User]?, String?) -> Void) {
        manager.request(model: SearchUserResponse.self, endpoint: UsersEndpoint.searchUsers.rawValue,   parameters: [
            "query": query,
            "page": page,
            "per_page": 20
        ]
    ) { data, errorMessage in
            if let errorMessage {
                completion(nil, errorMessage)
            } else if let data {
                completion(data.results, nil)
            }
        }
    }
}
