//
//  ItemTableViewCell.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/27/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import UIKit

protocol ItemCellDelegate {
    // Protocol to connect the actions in the cell with the ShoppingCart instance in the controller, in order to modify the quantity of the item, and to get the actual value.
    func didIncreaseItemQuantity(item: Item) -> String
    func didDecreaseItemQuantity(item: Item) -> String
    func getItemQuantity(item: Item) -> String
    
}

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var subtractOneButton: UIButton!
    @IBOutlet weak var addOneButton: UIButton!
    
    var itemCell: Item!
    var itemDelegate: ItemCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleButtons()
        styleImage()
    }
    
    func setItem(item: Item) {
        if let smallImageItem = item.smallImage as UIImage?, let _ = item.bigImage as UIImage? {
            itemCell = item
            nameLabel.text = item.name
            priceLabel.text = "$" + String(item.price)
            itemImage.image = smallImageItem
            quantityLabel.text = itemDelegate?.getItemQuantity(item: item)
        }
        handleButtons()
    }
    
    func handleButtons() {
        if let quantityLabelText = quantityLabel.text as String? {
            if quantityLabelText.elementsEqual("0") {
                addButton.isHidden = false
                addOneButton.isHidden = true
                subtractOneButton.isHidden = true
                quantityLabel.isHidden = true
            } else {
                addButton.isHidden = true
                addOneButton.isHidden = false
                subtractOneButton.isHidden = false
                quantityLabel.isHidden = false
            }
        } else {
            addButton.isHidden = false
            addOneButton.isHidden = true
            subtractOneButton.isHidden = true
            quantityLabel.isHidden = true
        }
    }

    // Rounded image in the cell.
    func styleImage() {
        itemImage.layer.masksToBounds = false
        itemImage.layer.cornerRadius = itemImage.frame.height / 2
        itemImage.clipsToBounds = true
    }
    
    // Add Button with the style in the design
    func styleButtons() {
        addButton.backgroundColor = .clear
        addButton.layer.cornerRadius = 15
        addButton.layer.borderColor = UIColor.purple.cgColor
        addButton.layer.borderWidth = 2
    }
    
    // Notify the increase of the item in the cell.
    @IBAction func increaseItemAction(_ sender: Any) {
        let newQuantityOfItem = itemDelegate?.didIncreaseItemQuantity(item: itemCell)
        quantityLabel.text = newQuantityOfItem
        handleButtons()
    }
    
    // Notify the decrease of the item in the cell.
    @IBAction func decreaseItemAction(_ sender: Any) {
        let newQuantityOfItem = itemDelegate?.didDecreaseItemQuantity(item: itemCell)
        quantityLabel.text = newQuantityOfItem
        handleButtons()
    }
}
