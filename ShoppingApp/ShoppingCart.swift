//
//  ShoppingCart.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/25/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation
import ObjectMapper

class ShoppingCart: Mappable {

    // Date data (Only for the purchases)
    var date: Date?
    // Dictionary to handle the relationship item and quantity.
    var itemQuantity: [Item: Int] = [:]
    var initialized = false
    
    required init?(map: Map) { }
    
    init() { }
    
    func mapping(map: Map) {
        date <- (map["date"], CustomDateTransform())
        var purchaseInfo: [PurchaseData]?
        purchaseInfo <- map["products"]
        fillShoppingCart(dataOfPurchase: purchaseInfo)
    }
    
    // Add the data to the dictionary property.
    func fillShoppingCart(dataOfPurchase: [PurchaseData]?) {
        if let data = dataOfPurchase as [PurchaseData]? {
            for info in data {
                if let item = info.item as Item?, let quantity = info.quantity as Int? {
                    itemQuantity[item] = quantity
                }
            }
        }
    }
    
    // Checks if there's at least one item in the dictionary.
    func isEmpty() -> Bool {
        for itemKey in itemQuantity.keys {
            let itemQuantity = getItemQuantity(itemToGet: itemKey)
            if itemQuantity > 0 {
                return false
            }
        }
        return true
    }
    
    // Return the number of items with its quantity different than zero.
    func itemsWithQuantity() -> [Item] {
        var itemsWithQuantity: [Item] = []
        for (item, quantity) in itemQuantity {
            if quantity > 0 {
                itemsWithQuantity.append(item)
            }
        }
        return itemsWithQuantity
    }
    
    // Initializes the dictionary in the shopping cart.
    func createItems(items: [Item]) {
        for item in items {
            itemQuantity[item] = 0
        }
        initialized = true
    }
    
    // Reinitializes dictionary to zero items.
    func clearItems() {
        for (item, _) in itemQuantity {
            itemQuantity[item] = 0
        }
    }

    // Method to calculate the final price after checkout.
    func getFinalPrice() -> Double {
        var finalPrice = 0.0
        for (item, quantity) in itemQuantity {
            if let price = item.price as Double? {
                let priceForItem = price * Double(quantity)
                finalPrice += priceForItem
            }
        }
        return finalPrice
    }
    
    // Method to increase one in the specified item.
    func addItem(itemToAdd: Item) -> Int {
        if var amountOfItem = itemQuantity[itemToAdd] as Int? {
            if amountOfItem < 10 {
                amountOfItem += 1
                itemQuantity[itemToAdd] = amountOfItem
            }
            return itemQuantity[itemToAdd]!
        } else {
            return 0
        }
    }
    
    // Method to decrease one in the specified item.
    func subtractItem(itemToSubtract: Item) -> Int {
        if var amountOfItem = itemQuantity[itemToSubtract] as Int? {
            if amountOfItem > 0 {
                amountOfItem -= 1
                itemQuantity[itemToSubtract] = amountOfItem
            }
            return itemQuantity[itemToSubtract]!
        } else {
            return 0
        }
    }
    
    // Method to get the amount of the specified item, from the dictionary.
    // Value in dictionary should not be nil, so return statement force unwrap of value.
    func getItemQuantity(itemToGet: Item) -> Int {
        return itemQuantity[itemToGet]!
    }
    
    // Method to get the amount of the specified item, from the dictionary.
    // Value in dictionary should not be nil, so return statement force unwrap of value.
    func setItemQuantity(itemToSet: Item, newQuantity: Int) {
        itemQuantity[itemToSet] = newQuantity
    }
    
    // Method to get the dictionary to use as parameter for the POST method.
    func createJSON() -> [String: Any] {
        var simulatedJSON: [[String: Any]] = []
        for (item, quantity) in itemQuantity {
            if quantity > 0 {
                var itemDictionary: [String: Any] = [:]
                itemDictionary["product_id"] = item.id
                itemDictionary["quantity"] = quantity
                simulatedJSON.append(itemDictionary)
            }
        }
        return [ "cart": simulatedJSON ]
    }
    
}
