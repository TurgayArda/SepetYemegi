//
//  SepetYemegiListCollectionCellViewModel.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 5.09.2022.
//

import Foundation

protocol SepetYemegiListCollectionCellViewModelProtocol {
    func getFoodName(food: FoodList) -> String
    func getFoodPrice(food: FoodList) -> String
}

class  SepetYemegiistCollectionCellViewModel: SepetYemegiListCollectionCellViewModelProtocol {
    func getFoodName(food: FoodList) -> String {
        guard let name = food.yemekAdi else {
            return "Unknow"
        }
        
        return name
    }
    
    func getFoodPrice(food: FoodList) -> String {
        guard let price = food.yemekFiyat else {
            return "Unknow"
        }
        
        return "$\(price)"
    }
}
