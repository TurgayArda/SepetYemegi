//
//  SepetYemegiBasketTableViewCellViewModel.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 8.09.2022.
//

import Foundation

protocol SepetYemegiBasketCollectionCellViewModelProtocol {
    func getFoodBasketName(food: BasketList) -> String
    func getFoodBasketPrice(food: BasketList) -> String
    func getFoodBasketPiece(food: BasketList) -> String
}

class  SepetYemegBasketCollectionCellViewModel: SepetYemegiBasketCollectionCellViewModelProtocol {
    func getFoodBasketName(food: BasketList) -> String {
        guard let name = food.yemekAdi else {
            return SepetYemegiListConstant.PropertyText.unknown.rawValue
        }
        
        return name
    }
    
    func getFoodBasketPiece(food: BasketList) -> String {
        guard let piece = food.yemekSiparisAdet else {
            return SepetYemegiListConstant.PropertyText.unknown.rawValue
        }
        
        return "\(piece)"
    }
    
    func getFoodBasketPrice(food: BasketList) -> String {
        guard let price = Int(food.yemekFiyat ?? ""), let piece = Int(food.yemekSiparisAdet ?? "") else {
            return SepetYemegiListConstant.PropertyText.unknown.rawValue
        }
        let result = price * piece
        return "₺\(result)"
    }
}
