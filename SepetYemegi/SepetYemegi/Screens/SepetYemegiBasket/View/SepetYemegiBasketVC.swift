//
//  SepetYemegiBasketVC.swift
//  SepetYemegi
//
//  Created by Arda Sisli on 8.09.2022.
//

import UIKit

class SepetYemegiBasketVC: UIViewController {
    
    //MARK: - Views
    
    @IBOutlet weak var foodBasketTableView: UITableView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultStackView: UIStackView!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    //MARK: - Properties
    
    private let colorView = UIColor(red: 0.98, green: 0.38, blue: 0.38, alpha: 1.00)
    private let foodBasketProvider = SepetYemegiBasketProvider()
    private var allBasketItem: [BasketList] = []
    private var basketlistData: [BasketList] = []
    
    var presenter: SepetYemegiBasketPresenterProtocol?
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initDelegate()
        presenter?.load()
    }
    
    //MARK: Private func
    
    private func initDelegate() {
        foodBasketProvider.delegate = self
        foodBasketTableView.delegate = foodBasketProvider
        foodBasketTableView.dataSource = foodBasketProvider
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = colorView
        navigationController?.navigationBar.tintColor = UIColor.white
        
        resultButton.setTitle(SepetYemegiBasketConstant.SepetYemegiBasketListConstant.resultButton.rawValue, for: .normal)
        resultButton.setTitleColor(.white, for: .normal)
        resultLabel.textColor = colorView
        resultLabel.text = "0"
        
        let rightButton = UIBarButtonItem(title: "", style: .plain , target: self, action: #selector(allBasketItem(_:)))
        let buttonIcon = UIImage(systemName: "trash")
        let changePlusImage = buttonIcon?.withTintColor(.white, renderingMode: .alwaysOriginal)
        rightButton.image = changePlusImage
        navigationItem.rightBarButtonItem = rightButton
        
        propertyLayer()
    }
    
    private func propertyLayer() {
        resultButton.layer.borderWidth = 0.5
        resultButton.layer.borderColor = UIColor.black.cgColor
        resultButton.layer.cornerRadius = 8
        resultButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        resultButton.backgroundColor = colorView
        
        resultLabel.layer.borderWidth = 0.5
        resultLabel.layer.borderColor = UIColor.black.cgColor
        resultLabel.layer.cornerRadius = 8
        resultLabel.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
    
    private func totalResult() {
        var total = 0
        for i in basketlistData {
            guard let price = Int(i.yemekFiyat ?? ""), let piece = Int(i.yemekSiparisAdet ?? "") else { return }
            total += price * piece
        }
        resultLabel.text = "\(total)"
    }
    
    @objc func allBasketItem(_ navigationItem: UIBarButtonItem) {
        for (index,i) in allBasketItem.enumerated() {
            guard let id = Int(i.yemekID ?? "") else { return }
            if index == (allBasketItem.count) - 1 {
                presenter?.deleteDataPresenter(itemID: id, isAllData: true, isDeleteItem: false)
            }else{
                presenter?.deleteDataPresenter(itemID: id, isAllData: false, isDeleteItem: false)
            }
        }
    }
    
    @IBAction func resultAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func equateItem(data: [BasketList]) {
        var foodName: [String] = []
        var pieceCount = 0
        basketlistData.removeAll()
        
        for (index,i) in data.enumerated() {
            for i in basketlistData {
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
        
        totalResult()
        foodBasketProvider.load(value: basketlistData)
    }
}

//MARK: - SepetYemegiBasketViewDelegate

extension SepetYemegiBasketVC:  SepetYemegiBasketViewDelegate {
    func handleOutPut(_ output: SepetYemegiBasketPresenterOutPut) {
        switch output {
        case .basketList(let basketList):
            allBasketItem.removeAll()
            self.allBasketItem = basketList
            equateItem(data: allBasketItem)
            DispatchQueue.main.async {
                self.foodBasketTableView.reloadData()
            }
        case .error(let error):
            print(error)
        case .title(let title):
            self.title = title
        }
    }
    
    func listBackHandleOutPut(_ output: SepetYemegiBasketBackListPresenterOutPut) {
        switch output {
        case .isBack(let isBack):
            if isBack {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

//MARK: - SepetYemegiBasketProviderDelegate

extension SepetYemegiBasketVC: SepetYemegiBasketProviderDelegate {
    func selected(at select: BasketList) {
        print(select)
    }
    
    func deleteBasketItem(data: BasketList) {
        guard let id = Int(data.yemekID ?? "") else {return }
        
        if basketlistData.count <= 1 {
            presenter?.deleteDataPresenter(itemID: id, isAllData: true, isDeleteItem: false)
            self.basketlistData.removeAll()
            foodBasketProvider.load(value: basketlistData)
            resultLabel.text = "0"
            self.foodBasketTableView.reloadData()
        }else{
            presenter?.deleteDataPresenter(itemID: id, isAllData: false, isDeleteItem: true)
        }
    }
}
