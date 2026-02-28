//
//  Photo.swift
//  Lumora
//
//  Created by Aynur on 24.02.26.
//

import Foundation

struct Photo: Codable {
    let id: String?
    let description: String?
    let altDescription: String?
    let urls: PhotoUrls?
    let user: PhotoUser?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case altDescription = "alt_description"
        case urls
        case user
    }
}

struct PhotoUrls: Codable {
    let small: String?
    let regular: String?
    let width: Int?
    let height: Int?
}

struct PhotoUser: Codable {
    let id: String?
    let name: String?
    let username: String?
}

