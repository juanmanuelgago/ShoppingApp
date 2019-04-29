//
//  ShoppingCart.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/25/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation

class ShoppingCart {
    
    var itemQuantity: [Item: Int] = [:]
    
    init() { }
    
    // Initializes the dictionary in the shopping cart.
    func createItems(items: [Item]) {
        for item in items {
            itemQuantity[item] = 0
        }
    }
    
    // TODO: Method to calculate the final price after checkout.
    func getFinalPrice() {
        
    }
    
    // TODO: Method to restore the dictionary to its initial state (Empty).
    func clearItems() {
        
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
    
}
