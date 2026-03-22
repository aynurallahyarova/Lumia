//
//  UsersUseCase.swift
//  Lumora
//
//  Created by Aynur on 22.03.26.
//

import Foundation

protocol UsersUseCase {
    func searchUsers(query: String, page: Int, completion: @escaping (([User]?, String?) -> Void))
}
