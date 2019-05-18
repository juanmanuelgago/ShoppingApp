//
//  ItemQuantityDelegate.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 5/6/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation
import UIKit

protocol ItemQuantityDelegate {
    // Protocol to connect the actions in the cells with the ShoppingBag instance in the controllers, in order to modify the quantity of the item, and to get the actual value.
    func didIncreaseItemQuantity(cell: UITableViewCell) -> String
    func didDecreaseItemQuantity(cell: UITableViewCell) -> String
}
