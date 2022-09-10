//
//  SepetYemegiListContracts.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 5.09.2022.
//

import UIKit

//MARK: - Interactor

protocol SepetYemegiListInteractorProtocol {
    var delegate: SepetYemegiListInteractorDelegate? { get set }
    func load()
    func loadBasket()
}

enum SepetYemegiListInteractorOutPut {
    case foodList([FoodList])
    case error(String)
}

enum SepetYemegiListBasketInteractorOutPut {
    case basketList([BasketList])
    case error(String)
}


protocol SepetYemegiListInteractorDelegate {
    func handleOutPut(_ output: SepetYemegiListInteractorOutPut)
    func basketHandleOutPut(_ output: SepetYemegiListBasketInteractorOutPut)
}

//MARK: - Presenter

protocol SepetYemegiListPresenterProtocol: AnyObject {
    func load()
    func loadBasket()
}

enum SepetYemegiListPresenterOutPut {
    case foodList([FoodList])
    case error(String)
    case title(String)
}

enum SepetYemegiListBasketPresenterOutPut {
    case basketList([BasketList])
    case error(String)
}

//MARK: - View

protocol SepetYemegiListViewDelegate {
    func handleOutPut(_ output: SepetYemegiListPresenterOutPut)
    func basketHandleOutPut(_ output: SepetYemegiListBasketPresenterOutPut)
}

//MARK: - CollectionViewProvider

protocol SepetYemegiListProviderProtocol {
    var delegate: SepetYemegiListProviderDelegate? { get set }
    func load(value: [FoodList])
    func searchLoad(data: [FoodList])
    func issearch(isSearch: Bool)
}

protocol SepetYemegiListProviderDelegate {
    func selected(at select: FoodList)
    func getWidth() -> CGFloat 
}

//MARK: - SearchBarProvider

protocol SepetYemegiListSearchBarProviderProtocol {
    var delegate: SepetYemegiListSearchBarProviderDelegate? { get set }
}

protocol SepetYemegiListSearchBarProviderDelegate {
    func searchKey(searchText: String)
    func cancelClicked()
}

//MARK: - Router

enum SepetYemegiListRouterOutPut {
    case detail(FoodList)
}

protocol SepetYemegiListRouterProtocol: AnyObject {
    func navigate(to route: SepetYemegiListRouterOutPut)
    func navigateBasket()
}
