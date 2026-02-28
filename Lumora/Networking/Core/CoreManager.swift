//
//  CoreManager.swift
//  Lumora
//
//  Created by Aynur on 24.02.26.
//

import Foundation
import Alamofire

@MainActor
class CoreManager {
    func request<T: Codable>(model: T.Type,
                             endpoint: String,
                             method: HTTPMethod = .get,
                             parameters: Parameters? = nil,
                             encoding: EncodingType = .url,
                             completion: @escaping((T?, String?) -> Void)
    ){
        AF.request(CoreHelper.shared.configureURL(endpoint: endpoint),
                   method: method,
                   parameters: parameters,
                   encoding: encoding == .url ? URLEncoding.default : JSONEncoding.default,
                   headers: CoreHelper.shared.headers
        )
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(result, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
        
    }
}
