//
//  SepetYemegiDetailContracts.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 6.09.2022.
//

import Foundation

//MARK: - Interactor

protocol SepetYemegiDetailInteractorProtocol {
    var delegate: SepetYemegiDetailInteractorDelegate? { get set }
    func load()
}

enum SepetYemegiDetailInteractorOutPut {
    case foodDetail(FoodList)
}

protocol SepetYemegiDetailInteractorDelegate {
    func handleOutPut(_ output: SepetYemegiDetailInteractorOutPut)
}

//MARK: - Presenter

protocol SepetYemegiDetailPresenterProtocol: AnyObject {
    func load()
//    func getTextFieldText() -> String
}

enum SepetYemegiDetailPresenterOutPut {
    case foodDetail(FoodList)
}

//MARK: - View

protocol SepetYemegiDetailViewDelegate {
    func handleOutPut(_ output: SepetYemegiDetailPresenterOutPut)
}