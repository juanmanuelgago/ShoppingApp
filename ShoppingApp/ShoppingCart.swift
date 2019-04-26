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
    
    // TODO: Method to increase one more value to the item in the parameter.
    // Need to check, maximum value is ten.
    func addItem(itemToAdd: Item) {
        
    }
    
    // TODO: Method to decrease one more value to the item in the parameter.
    // Need to check, minimum value is zero.
    func subtractItem(itemToSubtract: Item) {
        
    }
    
}
