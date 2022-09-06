//
//  SepetYemegiDetailBuilder.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 6.09.2022.
//

import Foundation

final class SepetYemegiDetailBuilder {
    static func make(foodDetail: FoodList) -> SepetYemegiDetailVC {
        let view = SepetYemegiDetailVC()
        let interactor = SepetYemegiDetailInteractor(foodDetail: foodDetail)
        let presenter = SepetYemegiDetailPresenter(interactor: interactor, view: view)
        view.presenter = presenter
        
        return view
    }
}
