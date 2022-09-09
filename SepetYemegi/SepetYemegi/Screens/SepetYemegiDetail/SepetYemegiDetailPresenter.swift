//
//  SepetYemegiDetailPresenter.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 6.09.2022.
//

import Foundation

class  SepetYemegiDetailPresenter:  SepetYemegiDetailPresenterProtocol {
    var interactor:  SepetYemegiDetailInteractorProtocol?
    let view:  SepetYemegiDetailViewDelegate?
    var foodDetail: FoodList?
    
    init(interactor: SepetYemegiDetailInteractorProtocol,
         view: SepetYemegiDetailViewDelegate
    ){
        self.interactor = interactor
        self.view = view
        self.interactor?.delegate = self
    }
}

extension SepetYemegiDetailPresenter {
    func load() {
        interactor?.load()
    }
    
    func addBasketPresenter(food: FoodList, pieceCount: Int, userName: String) {
        interactor?.addBasketInteractor(food: food, pieceCount: pieceCount, userName: userName)
    }
}

//MARK: - ToDosDetailInteractorDelegate

extension SepetYemegiDetailPresenter:  SepetYemegiDetailInteractorDelegate {
    func handleOutPut(_ output: SepetYemegiDetailInteractorOutPut) {
        switch output {
        case .foodDetail(let foodDetail):
            self.foodDetail = foodDetail
            view?.handleOutPut(.title(foodDetail.yemekAdi ?? ""))
            view?.handleOutPut(.foodDetail(foodDetail))
        }
    }
}

//MARK: - UI

extension SepetYemegiDetailPresenter {
    func getFoodName() -> String {
        guard let foodName = foodDetail?.yemekAdi else {
            return SepetYemegiDetailConstant.PropertyText.unknown.rawValue
        }
        
        return foodName
    }
    
    func getFoodPrice() -> String {
        guard let foodPrice = foodDetail?.yemekFiyat else {
            return SepetYemegiDetailConstant.PropertyText.unknown.rawValue
        }
        
        return "₺\(foodPrice)"
    }
}
