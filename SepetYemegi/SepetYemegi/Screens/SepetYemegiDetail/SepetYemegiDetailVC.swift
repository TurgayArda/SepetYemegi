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
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var addBasket: UIButton!
    
    //MARK: Properties
    
    private let colorView = UIColor(red: 0.98, green: 0.38, blue: 0.38, alpha: 1.00)
    
    var presenter: SepetYemegiDetailPresenterProtocol?
    
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        propertyLayer()
        presenter?.load()
    }
    
    private func propertyLayer() {
        view.backgroundColor = colorView
        
        foodImage.layer.borderWidth = 0.3
        foodImage.layer.borderColor = UIColor.gray.cgColor
        foodImage.layer.cornerRadius = 16
        
        addBasket.layer.borderWidth = 0.3
        addBasket.layer.borderColor = UIColor.gray.cgColor
        addBasket.layer.cornerRadius = 16
        
    }
    @IBAction func addBasket(_ sender: Any) {
        print("Arda")
    }
    
    private func propertyUI(foodDetail: FoodList) {
        foodName.text = presenter?.getFoodName()
        foodPrice.text = presenter?.getFoodPrice()
        
        if let imageName = foodDetail.yemekResimAdi {
            if let url = URL(string: SepetYemegiDetailConstant.SepetYemegiDetailImageURL.foodDetailImageURL(imageName: imageName)) {
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
        case .title(let title):
//            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            self.title = title
        }
    }
}
