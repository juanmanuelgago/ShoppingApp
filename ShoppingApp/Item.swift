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
    
    let id: Int
    let name: String
    let price: Double
    let category: ItemCategory
    let image: UIImage?
    
    init(id: Int, name: String, price: Double, category: ItemCategory, image: UIImage?) {
        self.id = id
        self.name = name
        self.price = price
        self.category = category
        self.image = image
    }
}

// This extension is needed for the dictionary property in the ShoppingBag class.
// The static method establishes how to consider that two objects of the Item class are equal.
extension Item: Hashable {
    var hashValue: Int {
        return id.hashValue ^ name.hashValue ^ price.hashValue
    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}
