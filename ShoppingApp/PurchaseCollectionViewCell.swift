//
//  PurchaseCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 5/25/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import UIKit

protocol PurchaseDetailsDelegate {
    // Protocol to connect the actions in the cells with the Purchase View controller.
    // Notifies the view controller that one of the cells in the collection was touched.
    func didRequestMoreDetails(cell: UICollectionViewCell)
}

class PurchaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var purchaseImage: UIImageView!
    @IBOutlet weak var purchaseQuantityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var purchaseTotalLabel: UILabel!
    @IBOutlet weak var moreDetailsButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    var purchaseDelegate: PurchaseDetailsDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleImage()
        styleButton()
        styleCardView()
    }

    // Creates the card layout for the cells in the collection view.
    func styleCardView() {
        cardView.layer.backgroundColor = UIColor(red: 250.0, green: 250.0, blue: 250.0, alpha: 1.0).cgColor
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOpacity = 0.75
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardView.layer.masksToBounds = false
    }
    
    // Styles the image as a circle.
    func styleImage() {
        purchaseImage.layer.masksToBounds = false
        purchaseImage.layer.cornerRadius = purchaseImage.frame.height / 2
        purchaseImage.clipsToBounds = true
    }
    
    func styleButton() {
        // Similar style to the add button in the shopping bag view controller.
        moreDetailsButton.backgroundColor = .clear
        moreDetailsButton.layer.cornerRadius = 15
        moreDetailsButton.layer.borderColor = UIColor.purple.cgColor
        moreDetailsButton.layer.borderWidth = 2
    }
    
    @IBAction func moreDetailAction(_ sender: Any) {
        // Communicates through the delegate with the historical view controller.
        purchaseDelegate?.didRequestMoreDetails(cell: self)
    }
}
