//
//  ShoppingBagViewController.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/19/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import UIKit

class ShoppingBagViewController: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    
    let shoppingCart = ShoppingCart()
    var banners: [ItemBanner] = []
    var items: [[Item]] = []
    var categories: [ItemCategory] = []
    
    var filteredItems: [[Item]] = []
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
    }
    
    func initialConfiguration() {
        let data = DataModelManager.shared.getDataForShoppingCart()
        for dataArray in data {
            shoppingCart.createItems(items: dataArray)
        }
        items = data
        banners = DataModelManager.shared.getDataForBanner()
        categories = DataModelManager.shared.getDataForCategories()
    }
    
    @IBAction func moveToSelectedBanner(_ sender: Any) {
        bannerCollectionView.scrollToItem(at: IndexPath(item: bannerPageControl.currentPage, section: 0), at: .right, animated: true)
    }
}

extension ShoppingBagViewController: UICollectionViewDelegate,
UICollectionViewDataSource, UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        bannerPageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        bannerPageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bannerPageControl.numberOfPages = banners.count
        bannerPageControl.isHidden = !(banners.count > 1)
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "BannerCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! BannerCollectionViewCell
        cell.bannerImageView.image = banners[indexPath.row].bannerImage
        cell.titleLabel.text = banners[indexPath.row].title
        cell.descriptionLabel.text = banners[indexPath.row].description
        return cell
    }

}

extension ShoppingBagViewController: ItemCellDelegate {

    // Calls the shopping bag instance to increase one, returns the new value.
    func didIncreaseItemQuantity(item: Item) -> String {
        let newValue = shoppingCart.addItem(itemToAdd: item)
        return String(newValue)
    }
    
    // Calls the shopping bag instance to decrease one, returns the new value.
    func didDecreaseItemQuantity(item: Item) -> String {
        let newValue = shoppingCart.subtractItem(itemToSubtract: item)
        return String(newValue)
    }
    
    func getItemQuantity(item: Item) -> String {
        let actualValue = shoppingCart.getItemQuantity(itemToGet: item)
        return  String(actualValue)
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
        cell.setItem(item: itemToPutInCell)
        cell.itemDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].rawValue
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
}

extension ShoppingBagViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            filteredItems = []
            let categories = itemTableView.numberOfSections
            var newFilteredItems: [[Item]] = []
            for i in 0...categories - 1 {
                var filteredItemsForCategory: [Item] = []
                filteredItemsForCategory = items[i].filter({ (item: Item) -> Bool in
                    return item.name.lowercased().contains(searchText.lowercased())
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
    
}




