//
//  ItemCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/29/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import UIKit
import Kingfisher

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
        if let name = item.name as String?, let price = item.price as Double? {
            if let photoUrl = item.photoUrl as String? {
                let url = URL(string: photoUrl)
                itemImage.kf.setImage(with: url)
            } else {
                let notFoundImage = UIImage(named: "no-photo")
                itemImage.image = notFoundImage
            }
            nameLabel.text = name
            priceLabel.text = "$" + String(price)
            quantityLabel.text = String(quantity) + " units"
        }
    }
}
