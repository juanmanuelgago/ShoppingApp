//
//  Item.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/25/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation
import UIKit

class Item {
    
    let name: String
    let price: Int
    let category: ItemCategory
    let smallImage: UIImage?
    let bigImage: UIImage?
    
    init(name: String, price: Int, category: ItemCategory, smallImage: UIImage?, bigImage: UIImage?) {
        self.name = name
        self.price = price
        self.category = category
        self.smallImage = smallImage
        self.bigImage = bigImage
    }
    
}

extension Item: Hashable {
    var hashValue: Int {
        return name.hashValue ^ price.hashValue
    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
    }
}
