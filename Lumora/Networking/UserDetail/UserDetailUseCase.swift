//
//  UserDetailUseCase.swift
//  Lumora
//
//  Created by Aynur on 30.03.26.
//

import Foundation

protocol UserDetailUseCase {
    func fetchUserDetail(userName: String, completion: @escaping (UserDetail?, String?) -> Void)
    func fetchUserPhoto(userName: String, completion: @escaping ([Photo]?, String?) -> Void)
}
