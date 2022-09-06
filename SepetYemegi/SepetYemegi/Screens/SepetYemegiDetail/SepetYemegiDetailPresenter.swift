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
}

//MARK: - ToDosDetailInteractorDelegate

extension SepetYemegiDetailPresenter:  SepetYemegiDetailInteractorDelegate {
    func handleOutPut(_ output: SepetYemegiDetailInteractorOutPut) {
        switch output {
        case .foodDetail(let foodDetail):
            view?.handleOutPut(.foodDetail(foodDetail))
        }
    }
}

//MARK: - UI

extension SepetYemegiDetailPresenter {
//    func getTextFieldText() -> String {
//        guard let text = todosData?.toDo_name else {
//            return ToDosDetailConstant.ViewsConstant.unknown.rawValue
//        }
//
//        return text
//    }
}
