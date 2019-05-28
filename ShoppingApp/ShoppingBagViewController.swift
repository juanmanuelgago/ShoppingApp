//
//  ShoppingBagViewController.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/19/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import UIKit
import Kingfisher

class ShoppingBagViewController: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    
    let shoppingCart = ShoppingCart()
    var banners: [ItemBanner] = []
    var items: [[Item]] = []
    var categories: [ItemCategory] = []
    
    // Array used when the search bar is being written. Here's the data to be shown.
    var filteredItems: [[Item]] = []
    // If there's something being written, this property is set to true.
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        styleSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        initData()
        // If the shopping cart changed a certain value, the table must refresh its cells.
        itemTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinyViewController = segue.destination as! CheckoutViewController
        destinyViewController.shoppingCart = self.shoppingCart
        destinyViewController.canCheckout = true // Allows the procedure of doing the checkout.
    }
    
    func initData() {
        // Add data to the banner array for the collection view.
        RemoteServiceManager.shared.getBanners { (arrayBanners, error) in
            if let _ = error as Error? {
                let alert = UIAlertController(title: "Error", message: "Unexpected error with the banners.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.banners = []
                if let arrayBanners = arrayBanners as [ItemBanner]? {
                    for itemBanner in arrayBanners {
                        if let itemBanner = itemBanner as ItemBanner? {
                            self.banners.append(itemBanner)
                        }
                    }
                    self.bannerCollectionView.reloadData()
                }                
            }
        }
        
        // Add data to the items array for the table view.
        RemoteServiceManager.shared.getItems { (arrayItems, error) in
            if let _ = error as Error? {
                let alert = UIAlertController(title: "Error", message: "Unexpected error with the items.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.items = []
                if let arrayItems = arrayItems as [Item]? {
                    var dairyItems: [Item] = []
                    var veggiesItems: [Item] = []
                    var fruitsItems: [Item] = []
                    for item in arrayItems {
                        if let item = item as Item? {
                            if let category = item.category as ItemCategory? {
                                switch category {
                                    case .dairy:
                                        dairyItems.append(item)
                                    case .veggie:
                                        veggiesItems.append(item)
                                    case .fruit:
                                        fruitsItems.append(item)
                                }
                            }
                        }
                    }
                    self.items = [dairyItems, fruitsItems, veggiesItems]
                    if !self.shoppingCart.initialized {
                        for arrayItems in self.items {
                            self.shoppingCart.createItems(items: arrayItems)
                        }
                    }
                    self.categories = [ItemCategory.dairy, ItemCategory.fruit, ItemCategory.veggie]
                    self.itemTableView.reloadData()
                }
            }
        }
        
    }
    
    // Add style to the search bar in the view.
    func styleSearchBar() {
        itemSearchBar.setImage(UIImage(named: "icon-search"), for: UISearchBarIcon.search, state: UIControlState.normal)
        if let textFieldSearch = itemSearchBar.value(forKey: "_searchField") as? UITextField {
            textFieldSearch.backgroundColor = UIColor(red: CGFloat(234/255.0), green: CGFloat(235/255.0), blue: CGFloat(242/255.0), alpha: CGFloat(1.0))
            textFieldSearch.textColor = UIColor(red: CGFloat(160/255.0), green: CGFloat(162/255.0), blue: CGFloat(178/255.0), alpha: CGFloat(1.0))
        }
    }
    
    // Action associated to the press of the pager under the banner.
    @IBAction func moveToSelectedBanner(_ sender: Any) {
        bannerCollectionView.scrollToItem(at: IndexPath(item: bannerPageControl.currentPage, section: 0), at: .right, animated: true)
    }
    
    // Controls the navigation to the checkout page, allowing or stopping the performSegue method.
    @IBAction func prepareShoppingBagForCheckout(_ sender: Any) {
        let isEmpty = shoppingCart.isEmpty()
        if !isEmpty {
            performSegue(withIdentifier: "CheckoutSegue", sender: self)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Your shopping cart is empty!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension ShoppingBagViewController: UICollectionViewDelegate,
UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        bannerPageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        bannerPageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    // Dismiss the keyboard when the view is scrolling.
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        itemSearchBar.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bannerPageControl.numberOfPages = banners.count
        bannerPageControl.isHidden = !(banners.count > 1)
        return banners.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "BannerCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! BannerCollectionViewCell
        if let url = banners[indexPath.row].photoUrl as String?, let name = banners[indexPath.row].name as String?, let description = banners[indexPath.row].description as String? {
            cell.bannerImageView.kf.setImage(with: URL(string: url))
            cell.titleLabel.text = name
            cell.descriptionLabel.text = description
        }
        return cell
    }
    
    // Establish the size of the cell in the collection view of the banners.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}

extension ShoppingBagViewController: ItemQuantityDelegate {
    
    // When the cell of the table executes an action of the protocol, the view controller updates the Shopping Cart declared.
    // Returns the new value after being set.
    
    func didIncreaseItemQuantity(cell: UITableViewCell) -> String {
        var newValue = "0"
        var item: Item
        if let cellLocation = itemTableView.indexPath(for: cell) as IndexPath? {
            if searching {
                item = filteredItems[cellLocation.section][cellLocation.row]
            } else {
                item = items[cellLocation.section][cellLocation.row]
            }
            let result = shoppingCart.addItem(itemToAdd: item)
            newValue = String(result)
        }
        return newValue
    }
    
    func didDecreaseItemQuantity(cell: UITableViewCell) -> String {
        var newValue = "0"
        var item: Item
        if let cellLocation = itemTableView.indexPath(for: cell) as IndexPath? {
            if searching {
                item = filteredItems[cellLocation.section][cellLocation.row]
            } else {
                item = items[cellLocation.section][cellLocation.row]
            }
            let result = shoppingCart.subtractItem(itemToSubtract: item)
            newValue = String(result)
        }
        return newValue
    }
}

extension ShoppingBagViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredItems[section].count
        } else {
            return items[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ItemTableViewCell
        var itemToPutInCell: Item
        if searching {
            itemToPutInCell = filteredItems[indexPath.section][indexPath.row]
        } else {
            itemToPutInCell = items[indexPath.section][indexPath.row]
        }
        cell.itemDelegate = self // The view controller is available to detect messages from the cell.
        let quantityOfItem = shoppingCart.getItemQuantity(itemToGet: itemToPutInCell)
        cell.setItemData(item: itemToPutInCell, quantity: quantityOfItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].rawValue.capitalizingFirstLetter()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
}

extension ShoppingBagViewController: UISearchBarDelegate {
    
    // Method is executed when the text of the search bar has changed.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            filteredItems = []
            let categories = itemTableView.numberOfSections
            var newFilteredItems: [[Item]] = []
            for i in 0...categories - 1 {
                var filteredItemsForCategory: [Item] = []
                filteredItemsForCategory = items[i].filter({ (item: Item) -> Bool in
                    if let name = item.name?.lowercased() as String? {
                        return name.contains(searchText.lowercased())
                    } else {
                        return false
                    }
                })
                newFilteredItems.append(filteredItemsForCategory)
            }
            filteredItems = newFilteredItems
            searching = true
        } else {
            searching = false
        }
        itemTableView.reloadData()
    }
    
    // Dismisses the keyboard if the search button is pressed.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        itemSearchBar.endEditing(true)
    }
    
}
