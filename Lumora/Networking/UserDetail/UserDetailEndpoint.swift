//
//  UserDetailEndpoint.swift
//  Lumora
//
//  Created by Aynur on 30.03.26.
//

import Foundation

enum UserDetailEndpoint {
    case userDetail(userName: String)
    case userPhotos(userName: String)
    
    var path: String {
        switch self {
        case .userDetail(userName: let userName):
            return "users/\(userName)"
        case .userPhotos(userName: let userName):
            return "users/\(userName)/photos"
        }
    }
}
