//
//  SepetYemegiDetailVC.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 6.09.2022.
//

import UIKit

class SepetYemegiDetailVC: UIViewController {
    
    //MARK: Views
    
    @IBOutlet weak var stackInView: UIView!
    @IBOutlet weak var parentStackView: UIStackView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var BasketStackView: UIStackView!
    @IBOutlet weak var minusButon: UIButton!
    @IBOutlet weak var pieceLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var addBasket: UIButton!
    
    //MARK: Properties
    
    private var foodDetail: FoodList?
    private var pieceCount = 1
    private let colorView = UIColor(red: 0.98, green: 0.38, blue: 0.38, alpha: 1.00)
    private let userName = "turgayarda"
    
    var presenter: SepetYemegiDetailPresenterProtocol?
    
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        configure()
        presenter?.load()
    }
    
    private func configure() {
        view.backgroundColor = colorView
        navigationController?.navigationBar.tintColor = UIColor.white
        pieceLabel.backgroundColor = colorView
        pieceLabel.textColor = .white
        
        let plusImage = UIImage(systemName: "plus")
        let changePlusImage = plusImage?.withTintColor(colorView, renderingMode: .alwaysOriginal)
        plusButton.setImage(changePlusImage, for: .normal)
        
        let minusImage = UIImage(systemName: "minus")
        let changeMinusImage = minusImage?.withTintColor(colorView, renderingMode: .alwaysOriginal)
        minusButon.setImage(changeMinusImage, for: .normal)
        
        
        propertyLayer()
    }
    
    private func propertyLayer() {
        minusButon.layer.borderWidth = 1
        minusButon.layer.borderColor = UIColor.black.cgColor
        minusButon.layer.cornerRadius = 8
        minusButon.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        pieceLabel.layer.borderWidth = 1
        pieceLabel.layer.borderColor = UIColor.black.cgColor
        
        plusButton.layer.borderWidth = 1
        plusButton.layer.borderColor = UIColor.black.cgColor
        plusButton.layer.cornerRadius = 8
        plusButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        foodImage.layer.borderWidth = 0.3
        foodImage.layer.borderColor = UIColor.gray.cgColor
        foodImage.layer.cornerRadius = 16
        
        addBasket.layer.borderWidth = 0.3
        addBasket.layer.borderColor = UIColor.gray.cgColor
        addBasket.layer.cornerRadius = 16
    }
    
    @IBAction func addBasket(_ sender: Any) {
        guard  let detail = foodDetail else { return }
        presenter?.addBasketPresenter(food: detail, pieceCount: pieceCount, userName: userName)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        switch pieceCount {
        case 1:
            print("1")
        default:
            pieceCount -= 1
            pieceLabel.text = "\(pieceCount)"
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        pieceCount += 1
        pieceLabel.text = "\(pieceCount)"
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
            self.foodDetail = foodDetail
            propertyUI(foodDetail: foodDetail)
        case .title(let title):
            self.title = title
        }
    }
}
