//
//  UserDetailManager.swift
//  Lumora
//
//  Created by Aynur on 30.03.26.
//

import Foundation

class UserDetailManager: UserDetailUseCase {
    private let manager = CoreManager()
    
    func fetchUserDetail(userName: String, completion: @escaping (UserDetail?, String?) -> Void) {
        manager.request(model: UserDetail.self, endpoint: UserDetailEndpoint.userDetail(userName: userName).path, completion: completion)
    }
    
    func fetchUserPhoto(userName: String, completion: @escaping ([Photo]?, String?) -> Void) {
        manager.request(model: [Photo].self, endpoint: UserDetailEndpoint.userPhotos(userName: userName).path, completion: completion)
    }
    
        
}
