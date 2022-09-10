//
//  SepetYemegiBasketBuilder.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 8.09.2022.
//

import UIKit

final class SepetYemegiBasketBuilder {
    static func make() -> SepetYemegiBasketVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SepetYemegiBasket") as! SepetYemegiBasketVC
        let interactor = SepetYemegiBasketInteractor(service: SepetYemegiService())
        let presenter = SepetYemegiBasketPresenter(interactor: interactor, view: view)
        view.presenter = presenter
        return view
    }
}
