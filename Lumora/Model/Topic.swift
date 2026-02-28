//
//  Topic.swift
//  Lumora
//
//  Created by Aynur on 24.02.26.
//

import Foundation

struct Topic: Codable {
    let id: String?
    let slug: String?
    let title: String?
    let description: String?
    let coverPhoto: Photo?
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case title
        case description
        case coverPhoto = "cover_photo"
    }
}
