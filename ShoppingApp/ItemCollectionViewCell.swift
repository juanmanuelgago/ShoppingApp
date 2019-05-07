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
    
    // The item associated to this cell is set in this variable.
    var itemCell: Item!
    // Allows the communication between the actions of this cell with the instance of the model in the view controller.
    // Only call needed from this delegate is when the item is being set.
    var itemDelegate: ItemQuantityDelegate?
    
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
    // The item is set to itemCell
    // Uses the delegate to retrieve the quantity of the item in the instance of the view controller.
    func setItem(item: Item) {
        if let _ = item.smallImage as UIImage?, let bigImageItem = item.bigImage as UIImage? {
            itemCell = item
            nameLabel.text = item.name
            priceLabel.text = "$" + String(item.price)
            itemImage.image = bigImageItem
            if let quantityLabelText = itemDelegate?.getItemQuantity(item: item) as String? {
                quantityLabel.text = quantityLabelText + " units"
            }
        }
    }
    
}
