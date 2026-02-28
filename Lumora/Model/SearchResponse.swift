//
//  Searchresponse.swift
//  Lumora
//
//  Created by Aynur on 24.02.26.
//

import Foundation

struct SearchUserResponse: Codable {
    let results: [User]
}

struct SearchPhotoResponse: Codable {
    let results: [Photo]
}
