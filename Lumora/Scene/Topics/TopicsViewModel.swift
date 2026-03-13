//
//  TopicsViewModel.swift
//  Lumora
//
//  Created by Aynur on 07.03.26.
//

import Foundation

final class TopicsViewModel {
    
    var topics: [Topic] = []
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    private let manager = CoreManager()
    
    func getTopics() {
        manager.request(model: [Topic].self, endpoint: "topics") { data, errorMessage in
            if let data {
                self.topics = data
                self.success?()
            } else if let errorMessage {
                self.error?(errorMessage)
            }
        }
    }
    
}

