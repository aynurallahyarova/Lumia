//
//  User.swift
//  Lumora
//
//  Created by Aynur on 24.02.26.
//

import Foundation

struct User: Codable {
    let id: String?
    let username: String?
    let name: String?
    let profileImage: ProfileImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let small: String?
    let medium: String?
}
