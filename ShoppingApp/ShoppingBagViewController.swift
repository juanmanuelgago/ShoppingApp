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
    
    let shoppingCart = ShoppingCart()
    var banners: [ItemBanner] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = DataModelManager.shared.getDataForShoppingCart()
        shoppingCart.createItems(items: data)
        
        banners = DataModelManager.shared.getDataForBanner()
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
        cell.bannerImageView.image = banners[indexPath.item].bannerImage
        cell.titleLabel.text = banners[indexPath.item].title
        cell.descriptionLabel.text = banners[indexPath.item].description
        return cell
    }

}


