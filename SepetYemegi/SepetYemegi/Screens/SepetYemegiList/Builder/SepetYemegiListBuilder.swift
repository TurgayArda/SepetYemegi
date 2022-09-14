//
//  SepetYemegiListBuilder.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 5.09.2022.
//

import UIKit

final class SepetYemegiListBuilder {
    static func make() -> SepetYemegiListVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "homeList") as! SepetYemegiListVC
        let interactor = SepetYemegiInteractor(service: SepetYemegiService())
        let presenter = SepetYemegiListPresenter(interactor: interactor, view: view)
        let router = SepetYemegiListRouter(view: view)
        view.presenter = presenter
        view.router = router
        return view
    }
}
