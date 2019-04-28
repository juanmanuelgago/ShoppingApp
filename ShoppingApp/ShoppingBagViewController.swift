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
    var items: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
    }
    
    func initialConfiguration() {
        let data = DataModelManager.shared.getDataForShoppingCart()
        shoppingCart.createItems(items: data)
        banners = DataModelManager.shared.getDataForBanner()
        items = data
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
        return shoppingCart.itemQuantity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ItemTableViewCell
        cell.setItem(item: items[indexPath.row])
        cell.itemDelegate = self
        return cell
    }
    
}




