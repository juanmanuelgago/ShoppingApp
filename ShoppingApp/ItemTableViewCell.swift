//
//  ItemTableViewCell.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/27/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import UIKit
import Foundation

protocol ItemQuantityDelegate {
    // Protocol to connect the actions in the cells with the ShoppingBag instance in the controllers.
    func didIncreaseItemQuantity(cell: UITableViewCell) -> String
    func didDecreaseItemQuantity(cell: UITableViewCell) -> String
}

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var subtractOneButton: UIButton!
    @IBOutlet weak var addOneButton: UIButton!
    
    // Allows the communication between the actions of this cell with the instance of the model in the view controller.
    var itemDelegate: ItemQuantityDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleButtons()
        styleImage()
    }
    
    // Assign the item information to the different outlets of the cell.
    // Uses the delegate to retrieve the quantity of the item in the instance of the view controller.
    func setItemData(item: Item, quantity: Int) {
        if let smallImageItem = item.smallImage as UIImage?, let _ = item.bigImage as UIImage? {
            nameLabel.text = item.name
            priceLabel.text = "$" + String(item.price)
            itemImage.image = smallImageItem
            quantityLabel.text = String(quantity)
        }
        handleButtons()
    }
    
    // Handles the hidden property in the cell, with the add, + and - button.
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
    
    // Add Button with the style in the design.
    func styleButtons() {
        addButton.backgroundColor = .clear
        addButton.layer.cornerRadius = 15
        addButton.layer.borderColor = UIColor.purple.cgColor
        addButton.layer.borderWidth = 2
    }
    
    // Notify the increase of the item in the cell.
    // Communicates through the delegate, so the shopping bag is updated as well.
    @IBAction func increaseItemAction(_ sender: Any) {
        let newQuantityOfItem = itemDelegate?.didIncreaseItemQuantity(cell: self)
        quantityLabel.text = newQuantityOfItem
        handleButtons()
    }
    
    // Notify the decrease of the item in the cell.
    // Communicates through the delegate, so the shopping bag is updated as well.
    @IBAction func decreaseItemAction(_ sender: Any) {
        let newQuantityOfItem = itemDelegate?.didDecreaseItemQuantity(cell: self)
        quantityLabel.text = newQuantityOfItem
        handleButtons()
    }
}
