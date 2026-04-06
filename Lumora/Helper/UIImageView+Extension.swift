//
//  UIImageView+Extension.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadURL(data: String) {
        let url = URL(string: data)
        kf.setImage(with: url)
    }
    func downloadImage(from urlString: String, completion: (() -> Void)? = nil) {
        guard let url = URL(string: urlString) else { return }
        
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let value):
                UIImageWriteToSavedPhotosAlbum(value.image, nil, nil, nil)
                completion?()
                
            case .failure(let error):
                print("Download error:", error)
            }
        }
    }
}
