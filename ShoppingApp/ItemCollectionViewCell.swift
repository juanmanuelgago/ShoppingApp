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
    
    var itemCell: Item!
    var itemDelegate: ItemQuantityDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleImage()
    }
    
    func styleImage() {
        itemImage.layer.cornerRadius = 7.5
        itemImage.clipsToBounds = true
    }
    
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
