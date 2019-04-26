//
//  ItemBanner.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/25/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation
import UIKit

class ItemBanner {
    
    let title: String
    let description: String
    let bannerImage: UIImage?
    
    init(title: String, description: String, bannerImage: UIImage) {
        self.title = title
        self.description = description
        self.bannerImage = bannerImage
    }
}
