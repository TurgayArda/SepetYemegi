//
//  SepetYemegiDetailVC.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 6.09.2022.
//

import UIKit

class SepetYemegiDetailVC: UIViewController {
    
    //MARK: Views
    
    @IBOutlet weak var parentStackView: UIStackView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var addBasket: UIButton!
    
    //MARK: Properties
    
    var presenter: SepetYemegiDetailPresenterProtocol?
    
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter?.load()
    }
    
    private func propertyUI(foodDetail: FoodList) {
        //guard let foodDetailTwo = foodDetail else { return }
        if let name = foodDetail.yemekAdi, let price = foodDetail.yemekFiyat {
            self.foodName.text = name
            self.foodPrice.text = price
        }
        
//        foodName.text = foodDetail.yemekAdi!
//        foodPrice.text = foodDetail.yemekFiyat!
//
        
        if let imageName = foodDetail.yemekResimAdi {
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(imageName)") {
            foodImage.af.setImage(withURL: url)
            }
        }
    }
}

//MARK: SepetYemegiDetailViewDelegate

extension SepetYemegiDetailVC:  SepetYemegiDetailViewDelegate {
    func handleOutPut(_ output: SepetYemegiDetailPresenterOutPut) {
        switch output {
        case .foodDetail(let foodDetail):
            propertyUI(foodDetail: foodDetail)
        }
    }
}
