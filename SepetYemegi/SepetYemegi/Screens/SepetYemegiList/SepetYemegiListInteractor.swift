//
//  SepetYemegiListInteractor.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 5.09.2022.
//

import Foundation

class SepetYemegiInteractor: SepetYemegiListInteractorProtocol {
    var delegate:SepetYemegiListInteractorDelegate?
    let service: SepetYemegiServiceProtocol?
    
    init(service: SepetYemegiServiceProtocol) {
        self.service = service
    }
}

extension SepetYemegiInteractor {
    func load() {
        //guard let url = URL(string: "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php") else { return }
        service?.fetch(url: "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",
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
}
