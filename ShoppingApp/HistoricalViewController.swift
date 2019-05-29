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
    
    var activityIndicator = UIActivityIndicatorView()
    
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
        startActivityIndicator()
        RemoteServiceManager.shared.getPurchases { (arrayPurchases, error) in
            if let _ = error as Error? {
                let alert = UIAlertController(title: "Error", message: "Unable to retrieve your previous purchases. Please, try again later.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.purchases = []
                if let arrayPurchases = arrayPurchases as [ShoppingCart]? {
                    self.purchases = arrayPurchases
                }
            }
            self.stopActivityIndicator()
            self.purchaseCollectionView.reloadData()
        }
    }
    
    // Handle the activity indicator. This method is called when the purchases are being retrieved.
    func startActivityIndicator() {
        let newView = UIView(frame: UIScreen.main.bounds)
        newView.tag = 100 // Random tag, for the process of dismissing the view.
        newView.backgroundColor = .white
        self.view.addSubview(newView)
        newView.addSubview(activityIndicator)
        activityIndicator.center = newView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        if let viewTag = self.view.viewWithTag(100) {
            viewTag.removeFromSuperview()
        }
    }
}

extension HistoricalViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: 225)
    }
    
}

extension HistoricalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if purchases.count == 0 {
            collectionView.setEmptyView(title: "Ups!", message: "You don't have any purchase made.")
        } else {
            collectionView.restore()
        }
        return purchases.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "PurchaseCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PurchaseCollectionViewCell
        cell.purchaseDelegate = self
        if let date = purchases[indexPath.row].date as Date? {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let stringDate = formatter.string(from: date)
            cell.dateLabel.text = stringDate
            formatter.dateFormat = "HH:mm"
            let hourDate = formatter.string(from: date)
            cell.hourLabel.text =  "at " + hourDate
        } else {
            cell.dateLabel.text = ""
            cell.hourLabel.text = ""
        }
        let quantity = purchases[indexPath.row].itemsWithQuantity().count
        if quantity > 1 {
            cell.purchaseQuantityLabel.text = String(quantity) + " items in the cart"
        } else if quantity == 1 {
            cell.purchaseQuantityLabel.text = String(quantity) + " item in the cart"
        }
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

extension UICollectionView {
    
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = emptyView
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
}






