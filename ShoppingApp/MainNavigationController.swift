//
//  MainNavigationController.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/19/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    let shoppingCart = ShoppingCart()
    var banners: [ItemBanner] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = DataModelManager.shared.getDataForShoppingCart()
        shoppingCart.createItems(items: data)
        
        banners = DataModelManager.shared.getDataForBanner()

        // Initializes the ShoppingCart
        // Load the data from the Singleton
    }

}
