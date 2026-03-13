//
//  HomeUseCase.swift
//  Lumora
//
//  Created by Aynur on 13.03.26.
//

import Foundation

protocol HomeUseCase {
    func fetchPhotos(page: Int, perPage: Int, completion: @escaping (([Photo]?, String?)-> Void))
    func searchPhotos(query: String, completion: @escaping (([Photo]?, String?) -> Void))
}
