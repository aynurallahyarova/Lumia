//
//  TopicUseCase.swift
//  Lumora
//
//  Created by Aynur on 20.03.26.
//

import Foundation

protocol TopicUseCase {
    func fetchTopicPhotos(topicId: String, page: Int, completion: @escaping ([Photo]?, String?) -> Void)
}
