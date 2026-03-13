//
//  PhotoDetailViewModel.swift
//  Lumora
//
//  Created by Aynur on 09.03.26.
//

import Foundation

class PhotoDetailViewModel {
    let photo: Photo
    init(photo: Photo) {
        self.photo = photo
    }
    
    var userName: String {
        photo.user?.name ?? ""
    }
    
    var imageURL: String {
        photo.urls?.regular ?? ""
    }
}
