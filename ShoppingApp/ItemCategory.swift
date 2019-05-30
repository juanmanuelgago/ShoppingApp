//
//  ItemCategory.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/25/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation

enum ItemCategory: String {
    case fruit = "fruits"
    case veggie = "veggies"
    case dairy = "dairy"
}

// This extension is made so the cases in the enum are written with the first letter in capital.
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
