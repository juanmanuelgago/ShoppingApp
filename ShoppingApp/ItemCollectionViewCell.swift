//
//  ItemCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/29/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleImage()
    }
    
    // Method to style the banner image in the cells of the collection view in the checkout view controller.
    func styleImage() {
        itemImage.layer.cornerRadius = 7.5
        itemImage.clipsToBounds = true
    }
    
    // Assign the item information to the different outlets of the cell.
    func setItemData(item: Item, quantity: Int) {
        if let _ = item.smallImage as UIImage?, let bigImageItem = item.bigImage as UIImage? {
            nameLabel.text = item.name
            priceLabel.text = "$" + String(item.price)
            itemImage.image = bigImageItem
            quantityLabel.text = String(quantity) + " units"
        }
    }
    
}
