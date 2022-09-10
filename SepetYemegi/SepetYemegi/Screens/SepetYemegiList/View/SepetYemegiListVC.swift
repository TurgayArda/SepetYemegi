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
    private var basketList: [BasketList] = []
    private var basketListError: String = ""
    private var badgeCount = 0
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
        presenter?.loadBasket()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.loadBasket()
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
        
        badgeItem(badgeCount: badgeCount)
        collectionLayout()
    }
    
    private func badgeItem(badgeCount: Int) {
        //MARK: - Badge Label
        
        let badgeLabel = UILabel(frame: CGRect(x: 12, y: 12, width: 21, height: 21))
        badgeLabel.layer.borderColor = UIColor.white.cgColor
        badgeLabel.layer.borderWidth = 0.5
        badgeLabel.adjustsFontSizeToFitWidth = true
        badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.height / 2
        badgeLabel.textAlignment = .center
        badgeLabel.layer.masksToBounds = true
        badgeLabel.font = .systemFont(ofSize: 10)
        badgeLabel.textColor = .black
        badgeLabel.backgroundColor = colorView
        badgeLabel.text = "\(badgeCount)"
        
        //MARK: - Badge button
        
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        let plusImage = UIImage(systemName: "bag", withConfiguration: imageConfiguration)
        let changePlusImage = plusImage?.withTintColor(.white, renderingMode: .alwaysOriginal)
        rightButton.setImage(changePlusImage, for: .normal)
        rightButton.addTarget(self, action: #selector(allBasketCount(_:)), for: .touchUpInside)
        rightButton.addSubview(badgeLabel)
        
        //MARK: - Navigation bar button item
        
        let rightBarButtomItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightBarButtomItem
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
    
    @objc func allBasketCount(_ navigationItem: UIBarButtonItem) {
        router?.navigateBasket()
    }
    
    private func equateBasketItem(data: [BasketList]) {
        var basketlistData: [BasketList] = []
        var foodName: [String] = []
        var pieceCount = 0
        
        for (index,i) in data.enumerated() {
            for i in basketlistData {
                foodName.removeAll()
                foodName.append(i.yemekAdi!)
            }
            
            switch index {
            case 0:
                basketlistData.append(i)
            default:
                if data[index].yemekAdi != data[index - 1].yemekAdi && foodName.contains(data[index].yemekAdi ?? "") == false {
                    basketlistData.append(data[index])
                }else{
                    for b in basketlistData {
                        if data[index].yemekAdi == b.yemekAdi {
                            pieceCount = 0
                            pieceCount += Int(data[index].yemekSiparisAdet ?? "") ?? 0
                            guard let pieceString = b.yemekSiparisAdet else { return }
                            guard var piece = Int(pieceString) else { return }
                            piece += pieceCount
                            for (index, _) in basketlistData.enumerated() {
                                if basketlistData[index].yemekAdi == b.yemekAdi {
                                    basketlistData[index].yemekSiparisAdet = String(piece)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        self.badgeCount = 0
        self.badgeCount = basketlistData.count
        badgeItem(badgeCount: badgeCount)
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
    
    func basketHandleOutPut(_ output: SepetYemegiListBasketPresenterOutPut) {
        switch output {
        case .basketList(let basketList):
            self.basketList = basketList
            equateBasketItem(data: basketList)
        case .error(let error):
            self.basketListError = error
            badgeItem(badgeCount: 0)
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
