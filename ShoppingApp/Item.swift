//
//  Item.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/25/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Item: Mappable {
    
    // Force unwrap the id. App to crash if values in this property are inconsistent.
    var id: Int!
    var name: String?
    var price: Double?
    var category: ItemCategory?
    var photoUrl: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        price <- (map["price"])
        category <- (map["category"], EnumTransform<ItemCategory>())
        photoUrl <- map["photoUrl"]
        setRoundedPrice()
    }
    
    func setRoundedPrice() {
        if let varPrice = price as Double? {
            let fullPrice = varPrice
            let roundedPrice = Double(round(10 * fullPrice) / 10)
            price = roundedPrice
        }
    }
}

// This extension is needed for the dictionary property in the ShoppingBag class.
// The static method establishes how to consider that two objects of the Item class are equal.
extension Item: Hashable {
    var hashValue: Int {
        if let name = name as String?, let price = price as Double? {
            return id.hashValue ^ name.hashValue ^ price.hashValue
        } else {
            return id.hashValue // Value forced.
        }
    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}
