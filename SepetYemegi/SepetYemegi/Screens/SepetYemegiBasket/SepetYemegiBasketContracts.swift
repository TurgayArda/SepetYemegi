//
//  SepetYemegiBasketContracts.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 8.09.2022.
//

import UIKit

//MARK: - Interactor

protocol SepetYemegiBasketInteractorProtocol {
    var delegate: SepetYemegiBasketInteractorDelegate? { get set }
    func load()
    func allDeleteInteractor(itemID: Int)
}

enum SepetYemegiBasketInteractorOutPut {
    case basketList([BasketList])
    case error(String)
}

protocol SepetYemegiBasketInteractorDelegate {
    func handleOutPut(_ output: SepetYemegiBasketInteractorOutPut)
}

//MARK: - Presenter

protocol SepetYemegiBasketPresenterProtocol: AnyObject {
    func load()
    func allDeletePresenter(itemID: Int)
}

enum SepetYemegiBasketPresenterOutPut {
    case basketList([BasketList])
    case error(String)
    case title(String)
}

//MARK: - View

protocol SepetYemegiBasketViewDelegate {
    func handleOutPut(_ output: SepetYemegiBasketPresenterOutPut)
}

//MARK: - CollectionViewProvider

protocol SepetYemegiBasketProviderProtocol {
    var delegate: SepetYemegiBasketProviderDelegate? { get set }
    func load(value: [BasketList])
    func removeAll()
}

protocol SepetYemegiBasketProviderDelegate {
    func selected(at select: BasketList)
    func deleteBasketItem(data: BasketList)
}

//MARK: - SearchBarProvider

protocol SepetYemegiBasketSearchBarProviderProtocol {
    var delegate: SepetYemegiListSearchBarProviderDelegate? { get set }
}

protocol SepetYemegiBasketSearchBarProviderDelegate {
    func searchKey(searchText: String)
    func cancelClicked()
}

//MARK: - Router

enum SepetYemegiBasketRouterOutPut {
    case detail(BasketList)
}

protocol SepetYemegiBasketRouterProtocol: AnyObject {
    func navigate(to route: SepetYemegiBasketRouterOutPut)
}

