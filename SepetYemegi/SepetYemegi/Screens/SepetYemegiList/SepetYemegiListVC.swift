//
//  SepetYemegiListVC.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 5.09.2022.
//

import UIKit

class SepetYemegiListVC: UIViewController {

    //MARK: - Views
    
    @IBOutlet weak var foodSearchBar: UISearchBar!
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    //MARK: - Properties
    
    private var foodListProvider = SepetYemegiListProvider()
    private var foodListSearchBarProvider = SepetYemegiListSearchBarProvider()
    private var foodList: [FoodList] = []
    private var foodListSearchData: [FoodList] = []
    private var isSearch = false
    private let colorNavigation = UIColor(red: 0.98, green: 0.38, blue: 0.38, alpha: 1.00) //pembis
    private let tableBackColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
    
  
    var presenter: SepetYemegiListPresenterProtocol?
    var router: SepetYemegiListRouterProtocol?
 
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SepetYemegiListBuilder.make(view: self)
        collectionLayout()
        initDelegate()
        presenter?.load()
    }
    
    //MARK: - Private Func
    
    private func collectionLayout() {
        let tasarim: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.foodCollectionView.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 5
        tasarim.minimumLineSpacing = 10
        let hucreGenislik =  (genislik - 30) / 2
        tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik * 1.85)
        foodCollectionView.collectionViewLayout = tasarim
    }
    
    private func initDelegate() {
        view.backgroundColor = colorNavigation
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
        foodListProvider.delegate = self
        foodListSearchBarProvider.delegate = self
        foodCollectionView.delegate = foodListProvider
        foodCollectionView.dataSource = foodListProvider
        foodSearchBar.delegate = foodListSearchBarProvider
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToDetail" {
//            guard let foodDetail = sender as? FoodList else { return }
//            let gidilecekVC =  SepetYemegiDetailInteractor()
//            gidilecekVC.foodDetail = foodDetail
//        }
//    }
}

//MARK: - SepetYemegiListSearchBarProviderDelegate

extension SepetYemegiListVC: SepetYemegiListSearchBarProviderDelegate {
    func searchKey(searchText: String) {
        foodListProvider.remove()
        foodListProvider.issearch(isSearch: true)
        let searchData = foodList.filter({ ($0.yemekAdi ?? "").lowercased().contains(searchText.lowercased())})
        foodListProvider.searchLoad(data: searchData)
        foodCollectionView.reloadData()
    }
    
    func cancelClicked() {
        foodListProvider.remove()
        foodListProvider.issearch(isSearch: false)
        foodListProvider.load(value: foodList)
        self.foodCollectionView.reloadData()
    }
}

//MARK: - SepetYemegiListViewDelegate

extension SepetYemegiListVC: SepetYemegiListViewDelegate {
    func handleOutPut(_ output: SepetYemegiListPresenterOutPut) {
        switch output {
        case .foodList(let foodList):
            self.foodList = foodList
            foodListProvider.issearch(isSearch: false)
            foodListProvider.load(value: foodList)
            DispatchQueue.main.async {
                self.foodCollectionView.reloadData()
            }
        case .error(let error):
            print(error)
        case .title(let title):
            self.title = title
        }
    }
}

//MARK: - SepetYemegiListProviderDelegate

extension SepetYemegiListVC: SepetYemegiListProviderDelegate {
    func selected(at select: FoodList) {
//        performSegue(withIdentifier: "goToDetail", sender: select)
        router?.navigate(to: .detail(select))
    }
    
    func getWidth() -> CGFloat {
        return view.frame.size.width
    }
}
