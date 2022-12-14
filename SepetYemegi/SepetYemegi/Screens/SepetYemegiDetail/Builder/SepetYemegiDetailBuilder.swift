//
//  SepetYemegiDetailBuilder.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 6.09.2022.
//

import UIKit

final class SepetYemegiDetailBuilder {
    static func make(foodDetail: FoodList) -> SepetYemegiDetailVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SepetYemegiDetail") as! SepetYemegiDetailVC
        let interactor = SepetYemegiDetailInteractor(foodDetail: foodDetail, service: SepetYemegiService())
        let presenter = SepetYemegiDetailPresenter(interactor: interactor, view: view)
        view.presenter = presenter
        
        return view
    }
}
