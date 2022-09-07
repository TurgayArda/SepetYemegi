//
//  SepetYemegiListCollectionViewCell.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 5.09.2022.
//

import UIKit
import AlamofireImage

class SepetYemegiListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var FoodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var EkleButton: UIButton!
    
    
    var cellViewModel: SepetYemegiListCollectionCellViewModelProtocol? 
    
    override func awakeFromNib() {
       super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.borderColor =  UIColor(red: 0.98, green: 0.38, blue: 0.38, alpha: 1.00).cgColor
        self.layer.cornerRadius = 8
        self.backgroundColor = .white
    }
    
    func propertyUI(food: FoodList) {
        foodName.text = cellViewModel?.getFoodName(food: food)
        foodPrice.text = cellViewModel?.getFoodPrice(food: food)
        
        if let imageName = food.yemekResimAdi {
            if let url = URL(string: SepetYemegiListConstant.imageURL.foodListImageURL(imageName: imageName)){
            FoodImage.af.setImage(withURL: url)
        }
    }
}
    
    func saveModel(value: FoodList) {
        propertyUI(food: value)
    }
   
}
