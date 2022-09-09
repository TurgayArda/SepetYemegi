//
//  SepetYemegiListModel.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 5.09.2022.
//

import Foundation

// MARK: - FoodResult

struct FoodListResult: Codable {
    let yemekler: [FoodList]?
    let success: Int?
}

// MARK: - Foods

struct FoodList: Codable {
    let yemekID, yemekAdi, yemekResimAdi, yemekFiyat: String?

    enum CodingKeys: String, CodingKey {
        case yemekID = "yemek_id"
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
    }
}
