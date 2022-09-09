//
//  SepetYemegiBasketInteractor.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 8.09.2022.
//

import Foundation
import Alamofire

class SepetYemegiBasketInteractor:  SepetYemegiBasketInteractorProtocol {
    var delegate: SepetYemegiBasketInteractorDelegate?
    let service: SepetYemegiServiceProtocol?
    let deleteService: GameListServiceProtocol?
    let userName = "turgayarda"
    
    init(service: SepetYemegiServiceProtocol, deleteService: GameListServiceProtocol) {
        self.service = service
        self.deleteService = deleteService
    }
}

extension  SepetYemegiBasketInteractor {
    func load() {
        let params: Parameters = ["kullanici_adi": userName]
        
        service?.fetch(url: "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",
                       parameters: params,
                       completion: { [delegate] (result: Result<BasketListResult, Error>) in
            switch result {
            case .success(let basketList):
                guard let basketListTwo = basketList.sepet_yemekler else { return }
                delegate?.handleOutPut(.basketList(basketListTwo))
            case .failure(let error):
                delegate?.handleOutPut(.error(error.localizedDescription))
            }
            
        })
    }
}

extension  SepetYemegiBasketInteractor {
    func allDeleteInteractor(itemID: Int) {
        let params: Parameters = ["sepet_yemek_id": itemID, "kullanici_adi": userName]
        //deleteService?.fetchAllData(url: "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", parameters: params)
        service?.fetch(url: "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",
                       parameters: params,
                       completion: { (result: Result<BasketList, Error>) in
            self.load()
        })
    }
}
