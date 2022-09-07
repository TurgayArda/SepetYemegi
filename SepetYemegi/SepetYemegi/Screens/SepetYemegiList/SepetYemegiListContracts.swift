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
}

enum SepetYemegiListInteractorOutPut {
    case foodList([FoodList])
    case error(String)
}

protocol SepetYemegiListInteractorDelegate {
    func handleOutPut(_ output: SepetYemegiListInteractorOutPut)
}

//MARK: - Presenter

protocol SepetYemegiListPresenterProtocol: AnyObject {
    func load()
}

enum SepetYemegiListPresenterOutPut {
    case foodList([FoodList])
    case error(String)
    case title(String)
}

//MARK: - View

protocol SepetYemegiListViewDelegate {
    func handleOutPut(_ output: SepetYemegiListPresenterOutPut)
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
}
