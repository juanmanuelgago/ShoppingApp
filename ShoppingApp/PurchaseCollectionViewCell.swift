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
    func didRequestMoreDetails(cell: UICollectionViewCell)
}

class PurchaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var purchaseImage: UIImageView!
    @IBOutlet weak var purchaseQuantityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
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
    
    func styleCardView() {
        cardView.layer.backgroundColor = UIColor.white.cgColor
        cardView.layer.cornerRadius = 5
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowColor = UIColor.darkGray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardView.layer.masksToBounds = false
    }
    
    func styleImage() {
        purchaseImage.layer.masksToBounds = false
        purchaseImage.layer.cornerRadius = purchaseImage.frame.height / 2
        purchaseImage.clipsToBounds = true
    }
    
    func styleButton() {
        moreDetailsButton.backgroundColor = .clear
        moreDetailsButton.layer.cornerRadius = 15
        moreDetailsButton.layer.borderColor = UIColor.purple.cgColor
        moreDetailsButton.layer.borderWidth = 2
    }
    
    @IBAction func moreDetailAction(_ sender: Any) {
        purchaseDelegate?.didRequestMoreDetails(cell: self)
    }
}
