//
//  SepetYemegiListSearchBarProvider.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 6.09.2022.
//

import UIKit

class SepetYemegiListSearchBarProvider: NSObject, SepetYemegiListSearchBarProviderProtocol {
    var delegate: SepetYemegiListSearchBarProviderDelegate?
    var searchText: String = ""
}

extension SepetYemegiListSearchBarProvider: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        delegate?.searchKey(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.cancelClicked()
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchKey(searchText: searchText)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
}
