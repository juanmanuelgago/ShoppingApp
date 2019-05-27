//
//  PurchaseData.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 5/26/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation
import ObjectMapper

class PurchaseData: Mappable {
    
    var item: Item?
    var quantity: Int?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        item <- map["product"]
        quantity <- map["quantity"]
    }
}
