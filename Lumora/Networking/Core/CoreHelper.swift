//
//  CoreHelper.swift
//  Lumora
//
//  Created by Aynur on 24.02.26.
//

import Foundation
import Alamofire

enum EncodingType {
    case url, json
}
class CoreHelper {
    static let shared = CoreHelper()
    
    private let baseURL = "https://api.unsplash.com/"
    private let accessKey = "IKyaJzigmsdTC6hOe5xOETUQn1iXt8sOCujGt_fkb14"
    
    let headers: HTTPHeaders = [
         "Authorization": "Client-ID IKyaJzigmsdTC6hOe5xOETUQn1iXt8sOCujGt_fkb14"
     ]
    func configureURL(endpoint: String) -> String {
        baseURL + endpoint
        
    }
}
