//
//  PurchaseData.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 5/26/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation
import ObjectMapper

/*
    This class is created as an intermediate object in the process of mapping of the shopping carts from the server.
    It's used to map the array of items with their quantity. That array is mapped from the shopping cart mapping function, under the property named "products".
    Then, the shopping cart creates the data of the dictionary with instances of this model.
 */
class PurchaseData: Mappable {
    
    var item: Item?
    var quantity: Int?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        item <- map["product"]
        quantity <- map["quantity"]
    }
}
