//
//  UserDetailViewModel.swift
//  Lumora
//
//  Created by Aynur on 30.03.26.
//

import Foundation

final class UserDetailViewModel {
    private let useCase: UserDetailUseCase
    
    var user: User
    var userdetail: UserDetail?
    var photos: [Photo] = []
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    init(useCase: UserDetailUseCase, user: User) {
        self.useCase = useCase
        self.user = user
    }
    
    
    func fetchUserDetail() {
        useCase.fetchUserDetail(userName: user.username ?? "") { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.userdetail = data
                self.success?()
            }
        }
    }
    
    func fetchUserPhotos() {
        useCase.fetchUserPhoto(userName: self.user.username ?? "") { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.photos = data
                self.success?()
            }
        }
    }
    func fetchAll() {
        fetchUserDetail()
        fetchUserPhotos()
    }
    
    //MARK: segment controller
    func changeSegment(index: Int) {
        switch index {
        case 0:
            fetchUserPhotos()
//        case 1:
            // likes falan
//        case 2:
//            // collections
        default:
            break
        }
    }
}



