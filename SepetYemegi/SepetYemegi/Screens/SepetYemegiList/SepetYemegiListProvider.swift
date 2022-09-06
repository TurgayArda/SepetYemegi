//
//  SepetYemegiListProvider.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 5.09.2022.
//

import UIKit

class SepetYemegiListProvider: NSObject {
    
    var delegate: SepetYemegiListProviderDelegate?
    var foodListData: [FoodList] = []
    var foodListSearchData: [FoodList] = []
    var isSearch = false
}

extension SepetYemegiListProvider: SepetYemegiListProviderProtocol {
    func load(value: [FoodList]) {
        self.foodListData = value
    }
    
    func searchLoad(data: [FoodList]) {
        self.foodListSearchData = data
    }
    
    func issearch(isSearch: Bool) {
        self.isSearch = isSearch
    }

    func remove() {
        foodListData.removeAll()
    }
}

extension SepetYemegiListProvider: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearch {
            return foodListSearchData.count
        }
        
        return foodListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SepetYemegiListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.cellViewModel = SepetYemegiistCollectionCellViewModel()
    
        if isSearch {
            let searchData = foodListSearchData[indexPath.row]
            cell.saveModel(value: searchData)
        }else{
            let data = foodListData[indexPath.row]
            cell.saveModel(value: data)
        }
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if isSearch {
            let searchRouterData = foodListSearchData[indexPath.row]
            delegate?.selected(at: searchRouterData)
        }else{
            let routerData = foodListData[indexPath.row]
            delegate?.selected(at: routerData)
        }
    }
}


