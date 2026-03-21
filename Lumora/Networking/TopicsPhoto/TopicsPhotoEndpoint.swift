//
//  TopicsPhotoEndpoint.swift
//  Lumora
//
//  Created by Aynur on 20.03.26.
//

import Foundation

enum TopicsPhotoEndpoint {
    case photos(topicID: String, page: Int, perPage: Int = 30)
    var path: String {
        switch self {
        case .photos(topicID: let topicID, page: _, perPage: _):
            return "topics/\(topicID)/photos"
        }
    }
    var parameters: [String: Any] {
        switch self {
        case .photos(topicID: _, page: let page, perPage: let perPage):
            return ["page": page, "per_page": perPage]
        }
    }
}
