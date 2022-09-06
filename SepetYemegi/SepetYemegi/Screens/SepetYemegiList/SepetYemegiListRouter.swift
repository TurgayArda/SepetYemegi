//
//  SepetYemegiListRouter.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 5.09.2022.
//

import UIKit

class SepetYemegiListRouter: SepetYemegiListRouterProtocol {
    let view: UIViewController
    init( view: UIViewController) {
        self.view = view
    }

    func navigate(to route: SepetYemegiListRouterOutPut) {
        switch route {
        case .detail(let foodDetail):
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let goToVC = storyboard.instantiateViewController(withIdentifier: "homeDetail") as! SepetYemegiDetailVC
            view.navigationController?.pushViewController(goToVC, animated: true)
            let viewController = SepetYemegiDetailBuilder.make(foodDetail: foodDetail)
            view.show(viewController, sender: nil)
        }
    }
}
