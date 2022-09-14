//
//  SplashVC.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 14.09.2022.
//

import UIKit
import Lottie

class SplashVC: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        animation()
    }
    
    private func configure() {
        animationView.alpha = 0
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.7
        animationView.play()
    }
    
    private func routerlist() {
        let viewController = SepetYemegiListBuilder.make()
        let vc = UINavigationController(rootViewController: viewController)
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: nil)
    }
    
    private func animation() {
        UIView.animate(withDuration: 5, animations: {
            self.animationView.alpha = 1
        }, completion: { _ in
            self.routerlist()
        })
    }
}
