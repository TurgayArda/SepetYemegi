//
//  SepetYemegiBasketTableViewCell.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 8.09.2022.
//

import UIKit

class SepetYemegiBasketTableViewCell: UITableViewCell {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var propertyStackView: UIStackView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var pieceLabel: UILabel!
    
    
    var cellViewModel: SepetYemegiBasketCollectionCellViewModelProtocol?
    private let colorView = UIColor(red: 0.98, green: 0.38, blue: 0.38, alpha: 1.00)
    
    override func awakeFromNib() {
        super.awakeFromNib()
       configure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func configure() {
        pieceLabel.layer.borderWidth = 0.3
        pieceLabel.layer.borderColor = UIColor.darkGray.cgColor
        pieceLabel.layer.cornerRadius = 8
    }
    
    private func propertyUI(food: BasketList) {
        foodName.text = cellViewModel?.getFoodBasketName(food: food)
        foodPrice.text = cellViewModel?.getFoodBasketPrice(food: food)
        pieceLabel.text = cellViewModel?.getFoodBasketPiece(food: food)
       
        if let imageName = food.yemekResimAdi {
            if let url = URL(string: SepetYemegiListConstant.imageURL.foodListImageURL(imageName: imageName)){
                foodImage.af.setImage(withURL: url)
        }
    }
    }
    
    func savemodel(data: BasketList) {
        propertyUI(food: data)
    }
}
