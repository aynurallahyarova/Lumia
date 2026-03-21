//
//  TopicsPhotoUseCase.swift
//  Lumora
//
//  Created by Aynur on 20.03.26.
//

import Foundation

protocol TopicsPhotoUseCase {
    func fetchTopicPhotos(topicId: String, page: Int, completion: @escaping ([Photo]?, String?) -> Void)
}
