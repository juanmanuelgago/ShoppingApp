//
//  ItemQuantityDelegate.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 5/6/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation

protocol ItemQuantityDelegate {
    // Protocol to connect the actions in the cells with the ShoppingBag instance in the controllers, in order to modify the quantity of the item, and to get the actual value.
    func didIncreaseItemQuantity(item: Item) -> String
    func didDecreaseItemQuantity(item: Item) -> String
    func getItemQuantity(item: Item) -> String
    
}
