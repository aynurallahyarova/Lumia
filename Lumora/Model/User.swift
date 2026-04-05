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
    let email: String?
    let fullname: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case profileImage = "profile_image"
        case email
        case fullname
    }
}

struct ProfileImage: Codable {
    let small: String?
    let medium: String?
}


