//
//  UserDetail.swift
//  Lumora
//
//  Created by Aynur on 23.03.26.
//

import Foundation

struct UserDetail: Codable {
    let id: String?
    let username: String?
    let name: String?
    let bio: String?
    let location: String?
    let totalPhotos: Int?
    let totalLikes: Int?
    let totalCollections: Int?
    let profileImage: ProfileImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case bio
        case location
        case totalPhotos = "total_photos"
        case totalLikes = "total_likes"
        case totalCollections = "total_collections"
        case profileImage = "profile_image"
    }
}
