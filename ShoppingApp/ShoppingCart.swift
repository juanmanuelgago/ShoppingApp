//
//  ShoppingCart.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/25/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation

class ShoppingCart {
    
    // Dictionary to handle the relationship item and quantity.s
    var itemQuantity: [Item: Int] = [:]
    
    init() { }
    
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
    }
    
    // Reinitializes dictionary to zero items.
    func clearItems() {
        for (item, _) in itemQuantity {
            itemQuantity[item] = 0
        }
    }

    // Method to calculate the final price after checkout.
    func getFinalPrice() -> Int {
        var finalPrice = 0
        for (item, quantity) in itemQuantity {
            let priceForItem = item.price * quantity
            finalPrice += priceForItem
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
        print("seteado!")
        print(itemQuantity[itemToSet]!)
    }
    
}
