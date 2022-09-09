//
//  SepetYemegiBasketModel.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 9.09.2022.
//

import Foundation

// MARK: - BasketFoodResult

struct BasketListResult: Codable {
    let sepet_yemekler: [BasketList]?
    let success: Int?
}

// MARK: - BasketFoods

struct BasketList: Codable {
    var yemekID, yemekAdi, yemekResimAdi, yemekFiyat, yemekSiparisAdet, kullaniciAdi: String?

    enum CodingKeys: String, CodingKey {
        case yemekID = "sepet_yemek_id"
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
        case yemekSiparisAdet = "yemek_siparis_adet"
        case kullaniciAdi = "kullanici_adi"
    }
}
