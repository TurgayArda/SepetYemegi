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
    
    private let color = UIColor(red: 0.98, green: 0.38, blue: 0.38, alpha: 1.00)
   
}

extension SepetYemegiBasketProvider: SepetYemegiBasketProviderProtocol {
    func load(value: [BasketList]) {
        self.foodBasketData = value
    }
    
    func removeAll() {
        self.foodBasketData.removeAll()
    }
}


extension SepetYemegiBasketProvider: UITableViewDelegate, UITableViewDataSource {
//    func clickButton(with title: String) {
//        getColor()
//
//        if colorList.isEmpty && title != "" {
//            addColor(title: title)
//        }else{
//            deleteAddColor(color: title)
//        }
//
////                for i in colorList {
////                    context.delete(i)
////                    appDelegate.saveContext()
////                }
//
//        delegate?.reload()
//}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodBasketData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell") as? SepetYemegiBasketTableViewCell else {
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
        }
        self.foodBasketData.removeAll()
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = color
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        guard let data = list[titleData[indexPath.section]] else { return }
//        let todosDataTwo = data[indexPath.row]
//
//        if isFilter {
//            guard let data = self.list[self.filterTitleData[indexPath.section]] else { return }
//            let filterDataTwo = data[indexPath.row]
//            self.delegate?.selected(at: filterDataTwo)
//        }else{
//            self.delegate?.selected(at: todosDataTwo)
//        }
//        self.delegate?.routerEdit()
//    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let view = UIView()
//        view.backgroundColor = .clear
//        cell.selectedBackgroundView = view
//    }
}
