//
//  Service.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 5.09.2022.
//

import Foundation
import Alamofire

enum HttpError: Error {
    case errorDecodingData
}


protocol SepetYemegiServiceProtocol {
    func fetch<T: Codable>(url: String, parameters: Parameters, completion: @escaping (Result<T, Error>) -> Void)
}

class SepetYemegiService: SepetYemegiServiceProtocol {
    func fetch<T: Codable>(url: String,
                           parameters: Parameters,
                           completion: @escaping (Result<T, Error>) -> Void) {

        AF.request(url, method: .post,parameters: parameters).responseDecodable(of: T.self) { food in
            guard let data = food.value else {
                return completion(.failure(HttpError.errorDecodingData))
            }
            completion(.success(data))
        }
    }
}
