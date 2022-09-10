//
//  SepetYemegiListInteractor.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 5.09.2022.
//

import Foundation
import Alamofire

class SepetYemegiInteractor: SepetYemegiListInteractorProtocol {
    var delegate:SepetYemegiListInteractorDelegate?
    let service: SepetYemegiServiceProtocol?
    let userName = "turgayarda"
    
    init(service: SepetYemegiServiceProtocol) {
        self.service = service
    }
}

extension SepetYemegiInteractor {
    func load() {
        service?.fetch(url: SepetYemegiListConstant.SepetYemegiListURL.foodListURL(), parameters: ["":nil ?? [[]]],
                       completion: { [delegate] (result: Result<FoodListResult, Error>) in
            switch result {
            case .success(let foodList):
                guard let foodListDataTwo =  foodList.yemekler else { return }
                delegate?.handleOutPut(.foodList(foodListDataTwo))
            case .failure(let error):
                delegate?.handleOutPut(.error(error.localizedDescription))
            }
        })
    }
    
    func loadBasket() {
        let params: Parameters = ["kullanici_adi": userName]
        
        service?.fetch(url: SepetYemegiListConstant.SepetYemegiListBasketListNetworkURL.sepetYemegiListBasketListtPath(),
                       parameters: params,
                       completion: { [delegate] (result: Result<BasketListResult, Error>) in
            switch result {
            case .success(let basketList):
                let basketListTwo = basketList.sepet_yemekler
                delegate?.basketHandleOutPut(.basketList(basketListTwo ?? []))
            case .failure(let error):
                delegate?.basketHandleOutPut(.error(error.localizedDescription))
            }
            
        })
    }
}
