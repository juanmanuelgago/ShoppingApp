//
//  ItemBanner.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/25/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class ItemBanner: Mappable {
    
    var name: String?
    var description: String?
    var photoUrl: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        photoUrl <- map["photoUrl"]        
    }
    
}
