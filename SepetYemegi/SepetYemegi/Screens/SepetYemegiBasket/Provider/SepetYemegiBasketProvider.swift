//
//  SepetYemegiBasketProvider.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 8.09.2022.
//

import UIKit

class SepetYemegiBasketProvider: NSObject {
    
    var delegate: SepetYemegiBasketProviderDelegate?
    var foodBasketData: [BasketList] = []
    let cellID = "basketCell"
    
    private let color = UIColor(red: 0.98, green: 0.38, blue: 0.38, alpha: 1.00)
    
}

//MARK: - SepetYemegiBasketProviderProtocol

extension SepetYemegiBasketProvider: SepetYemegiBasketProviderProtocol {
    func load(value: [BasketList]) {
        self.foodBasketData = value
    }
    
    func removeAll() {
        self.foodBasketData.removeAll()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension SepetYemegiBasketProvider: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodBasketData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? SepetYemegiBasketTableViewCell else {
            return UITableViewCell()
        }
        
        cell.cellViewModel = SepetYemegBasketCollectionCellViewModel()
        
        let basketListData = foodBasketData[indexPath.row]
        cell.savemodel(data: basketListData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let foodBasketDataTwo = foodBasketData[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (contextualAction, view, bool) in
            self.delegate?.deleteBasketItem(data: foodBasketDataTwo)
            self.foodBasketData.removeAll()
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = color
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
