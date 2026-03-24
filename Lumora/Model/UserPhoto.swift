//
//  UserPhoto.swift
//  Lumora
//
//  Created by Aynur on 23.03.26.
//

import Foundation

struct UserPhoto: Codable {
    let id: String?
    let urls: Urls?
}

struct Urls: Codable {
    let small: String?
    let regular: String?
}
