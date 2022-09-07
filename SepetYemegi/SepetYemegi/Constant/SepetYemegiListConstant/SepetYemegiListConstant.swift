//
//  SepetYemegiListConstant.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 7.09.2022.
//

import Foundation

final class SepetYemegiListConstant {
    enum SepetYemegiListURL: String {
        case path_url =  "http://kasimadalan.pe.hu/yemekler/"
        case type_url = "tumYemekleriGetir.php"
        
        static func foodListURL() -> String {
            return "\(path_url.rawValue)\(type_url.rawValue)"
        }
    }
    
    enum SepetYemegiListTitle: String {
        case title = "SepetYemegi"
    }
    
    enum PropertyText: String {
        case unknown = "Unknown"
    }
    
    enum imageURL: String {
        case path_url =  "http://kasimadalan.pe.hu/yemekler/"
        case type_url = "resimler/"
        
        static func foodListImageURL(imageName: String) -> String {
            return "\(path_url.rawValue)\(type_url.rawValue)\(imageName)"
        }
    }
}
