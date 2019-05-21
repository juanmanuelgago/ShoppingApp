//
//  Purchase.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 5/21/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation

class Purchase {
    
    let date: Date
    let shoppingCart: ShoppingCart
    
    init(date: Date, shoppingCart: ShoppingCart) {
        self.date = date
        self.shoppingCart = shoppingCart
    }
}
