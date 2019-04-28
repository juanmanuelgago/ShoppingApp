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
    
    let shoppingCart = ShoppingCart()
    var banners: [ItemBanner] = []
    var items: [[Item]] = []
    var categories: [ItemCategory] = []

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
    
}

extension ShoppingBagViewController: UICollectionViewDelegate,
UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
}

extension ShoppingBagViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ItemTableViewCell
        let itemToPutInCell = items[indexPath.section][indexPath.row]
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




