//
//  SepetYemegiListPresenter.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 5.09.2022.
//

import Foundation

class SepetYemegiListPresenter: SepetYemegiListPresenterProtocol {
    var interactor: SepetYemegiListInteractorProtocol?
    let view: SepetYemegiListViewDelegate?
    
    init(interactor: SepetYemegiListInteractorProtocol,
         view: SepetYemegiListViewDelegate
    ){
        self.interactor = interactor
        self.view = view
        self.interactor?.delegate = self
    }
}

extension SepetYemegiListPresenter {
    func load() {
        interactor?.load()
    }
    
    func loadBasket() {
        interactor?.loadBasket()
    }
}

extension SepetYemegiListPresenter: SepetYemegiListInteractorDelegate {
    func handleOutPut(_ output: SepetYemegiListInteractorOutPut) {
        switch output {
        case .foodList(let foodList):
            view?.handleOutPut(.title(SepetYemegiListConstant.SepetYemegiListTitle.title.rawValue))
            view?.handleOutPut(.foodList(foodList))
        case .error(let error):
            view?.handleOutPut(.error(error))
        }
    }
    
    func basketHandleOutPut(_ output: SepetYemegiListBasketInteractorOutPut) {
        switch output {
        case .basketList(let basketList):
            view?.basketHandleOutPut(.basketList(basketList))
        case .error(let error):
            view?.basketHandleOutPut(.error(error))
        }
    }
}
