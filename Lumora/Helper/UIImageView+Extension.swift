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
}
