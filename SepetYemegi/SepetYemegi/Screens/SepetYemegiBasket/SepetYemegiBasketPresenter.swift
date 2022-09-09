//
//  SepetYemegiBasketPresenter.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 8.09.2022.
//

import Foundation

class SepetYemegiBasketPresenter: SepetYemegiBasketPresenterProtocol {
    var interactor: SepetYemegiBasketInteractorProtocol?
    let view: SepetYemegiBasketViewDelegate?
    
    init(interactor: SepetYemegiBasketInteractorProtocol,
         view: SepetYemegiBasketViewDelegate
    ){
        self.interactor = interactor
        self.view = view
        self.interactor?.delegate = self
    }
}

extension SepetYemegiBasketPresenter {
    func load() {
        interactor?.load()
    }
}

extension SepetYemegiBasketPresenter {
    func allDeletePresenter(itemID: Int) {
        interactor?.allDeleteInteractor(itemID: itemID)
    }
}

extension SepetYemegiBasketPresenter: SepetYemegiBasketInteractorDelegate {
    func handleOutPut(_ output: SepetYemegiBasketInteractorOutPut) {
        view?.handleOutPut(.title("Basket"))
        switch output {
        case .basketList(let basketList):
            view?.handleOutPut(.basketList(basketList))
        case .error(let error):
            view?.handleOutPut(.error(error))
        }
    }
}
