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
    @IBOutlet weak var basketButton: UIBarButtonItem!
    
    //MARK: - Properties
    
    private var foodListProvider = SepetYemegiListProvider()
    private var foodListSearchBarProvider = SepetYemegiListSearchBarProvider()
    private var foodList: [FoodList] = []
    private var foodListSearchData: [FoodList] = []
    private var isSearch = false
    private let colorView = UIColor(red: 0.98, green: 0.38, blue: 0.38, alpha: 1.00)
    private let tableBackColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
    
    var presenter: SepetYemegiListPresenterProtocol?
    var router: SepetYemegiListRouterProtocol?
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SepetYemegiListBuilder.make(view: self)
        initDelegate()
        presenter?.load()
    }
    
    //MARK: - Private Func
    
    private func initDelegate() {
        foodListProvider.delegate = self
        foodListSearchBarProvider.delegate = self
        foodCollectionView.delegate = foodListProvider
        foodCollectionView.dataSource = foodListProvider
        foodSearchBar.delegate = foodListSearchBarProvider
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = colorView
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let basketImage = UIImage(systemName: "bag")
        let changePlusImage = basketImage?.withTintColor(.white, renderingMode: .alwaysOriginal)
        basketButton.image = changePlusImage
        
        collectionLayout()
        
    }
    
    private func collectionLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let foodWidth = self.foodCollectionView.frame.size.width
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        let cellWidth =  (foodWidth - 30) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.35)
        foodCollectionView.collectionViewLayout = layout
    }
    
    @IBAction func goToBasket(_ sender: Any) {
        router?.navigateBasket()
    }
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
        router?.navigate(to: .detail(select))
    }
    
    func getWidth() -> CGFloat {
        return view.frame.size.width
    }
}
