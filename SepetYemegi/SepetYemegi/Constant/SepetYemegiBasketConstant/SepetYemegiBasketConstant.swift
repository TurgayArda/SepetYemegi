//
//  SepetYemegiBasketConstant.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 10.09.2022.
//

import Foundation

final class SepetYemegiBasketConstant {
    enum  SepetYemegiBasketListNetworkURL: String {
        case path_url = "http://kasimadalan.pe.hu/yemekler/"
        case food_url = "sepettekiYemekleriGetir.php"
        
        static func sepetYemegiBasketListPath() -> String {
            return "\(path_url.rawValue)\(food_url.rawValue)"
        }
    }
  
    enum  SepetYemegiBasketDeleteNetworkURL: String {
        case path_url = "http://kasimadalan.pe.hu/yemekler/"
        case food_url = "sepettenYemekSil.php"
        
        static func sepetYemegiBasketDeletePath() -> String {
            return "\(path_url.rawValue)\(food_url.rawValue)"
        }
    }
    
    enum SepetYemegiBasketListConstant: String {
        case title = "Basket"
        case resultButton = "Continue"
    }
}
