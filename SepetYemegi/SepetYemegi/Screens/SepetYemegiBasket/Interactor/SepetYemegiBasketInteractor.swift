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
    let userName = "turgayarda"
    
    init(service: SepetYemegiServiceProtocol) {
        self.service = service
    }
}

//MARK: - SepetYemegiBasketInteractorProtocol

extension  SepetYemegiBasketInteractor {
    func load() {
        let params: Parameters = ["kullanici_adi": userName]
        
        service?.fetch(url: SepetYemegiBasketConstant.SepetYemegiBasketListNetworkURL.sepetYemegiBasketListPath(),
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
    func deleteDataInteractor(itemID: Int, isAllData: Bool, isDeleteItem: Bool) {
        let params: Parameters = ["sepet_yemek_id": itemID,
                                  "kullanici_adi": userName
        ]
        
        service?.fetch(url: SepetYemegiBasketConstant.SepetYemegiBasketDeleteNetworkURL.sepetYemegiBasketDeletePath(),
                       parameters: params,
                       completion: { [delegate] (result: Result<BasketList, Error>) in
            
            if isAllData {
                delegate?.listBackHandleOutPut(.isBack(true))
            }
            
            if isDeleteItem {
                self.load()
            }
        })
    }
}
