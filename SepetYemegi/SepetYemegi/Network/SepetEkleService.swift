//
//  SepetEkleService.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 9.09.2022.
//

import Foundation
import Alamofire

protocol GameListServiceProtocol {
    func fetchAllData(url: String,
                      parameters: Parameters)
}

class GameListService: GameListServiceProtocol {
    func fetchAllData(url: String,
                      parameters: Parameters) {
        AF.request(url, method: .post, parameters: parameters).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONSerialization.jsonObject(with: data)
                    print(cevap)
                }catch{print(error.localizedDescription)}
            }
        }
    }
}

