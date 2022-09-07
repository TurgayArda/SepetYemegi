//
//  SepetYemegiDetailConstant.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 7.09.2022.
//

import Foundation

final class SepetYemegiDetailConstant {
    enum SepetYemegiDetailImageURL: String {
        case path_url =  "http://kasimadalan.pe.hu/yemekler/"
        case type_url = "resimler/"
        
        static func foodDetailImageURL(imageName: String) -> String {
            return "\(path_url.rawValue)\(type_url.rawValue)\(imageName)"
        }
    }
    
    enum PropertyText: String {
        case unknown = "Unknown"
    }
}
