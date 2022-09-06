//
//  SepetYemegiDetailInteractor.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 6.09.2022.
//

import Foundation

class SepetYemegiDetailInteractor: SepetYemegiDetailInteractorProtocol {
    var delegate: SepetYemegiDetailInteractorDelegate?
    var foodDetail: FoodList?
    
    init(foodDetail: FoodList) {
        self.foodDetail = foodDetail
    }
}

extension SepetYemegiDetailInteractor {
    func load() {
        guard let foodDetailTwo = foodDetail else { return }
        delegate?.handleOutPut(.foodDetail(foodDetailTwo))
    }
}
