//
//  HistoricalViewController.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 5/25/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import UIKit
import Kingfisher

class HistoricalViewController: UIViewController {

    @IBOutlet weak var purchaseCollectionView: UICollectionView!
    
    var purchases: [ShoppingCart] = []
    var selectedPurchase: ShoppingCart?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initData()
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinyViewController = segue.destination as! CheckoutViewController
        if let selectedPurchase = selectedPurchase as ShoppingCart? {
            destinyViewController.shoppingCart = selectedPurchase
            destinyViewController.canCheckout = false // Read-Only mode for the next view controller.
        }
    }
    
    func initData() {
        RemoteServiceManager.shared.getPurchases { (arrayPurchases, error) in
            if let error = error as Error? {
                print("llego un error en get purchases")
                print(error)
            } else {
                self.purchases = []
                if let arrayPurchases = arrayPurchases as [ShoppingCart]? {
                    self.purchases =  arrayPurchases
                    print(self.purchases)
                }
            }
            self.purchaseCollectionView.reloadData()
        }
    }
}

extension HistoricalViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: 200)
    }
    
}

extension HistoricalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "PurchaseCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PurchaseCollectionViewCell
        cell.purchaseDelegate = self
        if let date = purchases[indexPath.row].date as Date? {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            let stringDate = formatter.string(from: date)
            cell.dateLabel.text = stringDate
        } else {
            cell.dateLabel.text = "No date information"
        }
        cell.purchaseQuantityLabel.text = String(purchases[indexPath.row].itemsWithQuantity().count) + " items in the cart"
        cell.purchaseTotalLabel.text = "$" + String(purchases[indexPath.row].getFinalPrice())
        cell.purchaseImage.image = UIImage(named: "cart1")
        return cell
    }
}

extension HistoricalViewController: PurchaseDetailsDelegate {
    func didRequestMoreDetails(cell: UICollectionViewCell) {
        if let cellLocation = purchaseCollectionView.indexPath(for: cell) as IndexPath? {
            let purchaseSelected = purchases[cellLocation.row]
            selectedPurchase = purchaseSelected
            performSegue(withIdentifier: "DetailSegue", sender: self)
        }
    }
}






