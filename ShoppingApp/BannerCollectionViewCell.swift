//
//  BannerCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/27/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleImage()
    }
    
    func styleImage() {
        bannerImageView.layer.cornerRadius = 5
        bannerImageView.clipsToBounds = true
    }
    
}
