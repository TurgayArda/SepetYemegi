//
//  SepetYemegiDetailInteractor.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 6.09.2022.
//

import Foundation
import Alamofire

class SepetYemegiDetailInteractor: SepetYemegiDetailInteractorProtocol {
    var delegate: SepetYemegiDetailInteractorDelegate?
    let service: SepetYemegiServiceProtocol?
    var foodDetail: FoodList?
    
    init(foodDetail: FoodList, service: SepetYemegiServiceProtocol) {
        self.foodDetail = foodDetail
        self.service = service
    }
}

extension SepetYemegiDetailInteractor {
    func load() {
        guard let foodDetailTwo = foodDetail else { return }
        delegate?.handleOutPut(.foodDetail(foodDetailTwo))
    }
    
    func addBasketInteractor(food: FoodList, pieceCount: Int, userName: String) {
        guard let name = food.yemekAdi, let price = Int(food.yemekFiyat ?? ""), let image = food.yemekResimAdi else { return }
        let params: Parameters = ["yemek_adi": name,
                                  "yemek_resim_adi": image,
                                  "yemek_fiyat": price,
                                  "yemek_siparis_adet": pieceCount,
                                  "kullanici_adi": userName
        ]
        
        service?.fetch(url: SepetYemegiDetailConstant.SepetYemegiDetailNetworkURL.sepetYemegiDetailPath(),
                       parameters: params,
                       completion: { [delegate] (result: Result<FoodListResult, Error>) in
            delegate?.backHandleOutPut(.isBack(true))
        })
    }
}
