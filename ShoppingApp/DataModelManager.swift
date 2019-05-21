//
//  DataModelManager.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/25/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation
import UIKit

class DataModelManager {
    
    static let shared = DataModelManager()
    
    private init() { }
    
    // Initialize data for the ViewController
    func getDataForShoppingCart() -> [[Item]] {
        
        let avocadoImage = UIImage(named: "Avocado")!
        let avocadoItem = Item(id: 1, name: "Avocado", price: 10.0, category: ItemCategory.veggie, image: avocadoImage)
        
        let cucumberImage = UIImage(named: "Cucumber")!
        let cucumberItem = Item(id: 2, name: "Cucumber", price: 10.0, category: ItemCategory.veggie, image: cucumberImage)

        let grapefruitImage = UIImage(named: "Grapefruit")!
        let grapefruitItem = Item(id: 3, name: "Grapefruit", price: 10.0, category: ItemCategory.fruit, image: grapefruitImage)
        
        let kiwiImage = UIImage(named: "Kiwi")!
        let kiwiItem = Item(id: 4, name: "Kiwi", price: 10.0, category: ItemCategory.fruit, image: kiwiImage)
        
        let watermelonImage = UIImage(named: "Watermelon")!
        let watermelonItem = Item(id: 5, name: "Watermelon", price: 10.0, category: ItemCategory.fruit, image: watermelonImage)

        let fruitArray = [grapefruitItem, kiwiItem, watermelonItem]
        let veggieArray = [avocadoItem, cucumberItem]

        return [fruitArray, veggieArray]
    }
    
    func getDataForBanner() -> [ItemBanner] {
        
        let bananaBannerImage = UIImage(named: "Banner-1")!
        let bananaBanner = ItemBanner(title: "Brazilian Bananas", description: "Product of the Month", bannerImage: bananaBannerImage)
        
        let grapefruitBannerImage = UIImage(named: "Banner-2")!
        let grapefruitBanner = ItemBanner(title: "Tropical Grapefruit", description: "Product of the Month", bannerImage: grapefruitBannerImage)

        let cucumberBannerImage = UIImage(named: "Banner-3")!
        let cucumberBanner = ItemBanner(title: "Asian Cucumber", description: "Product of the Month", bannerImage: cucumberBannerImage)
        
        let kiwiBannerImage = UIImage(named: "Banner-4")!
        let kiwiBanner = ItemBanner(title: "Australian Kiwis", description: "Product of the Month", bannerImage: kiwiBannerImage)
        
        let arrayItems = [bananaBanner, grapefruitBanner, cucumberBanner, kiwiBanner]
        return arrayItems
        
    }
    
    func getDataForCategories() -> [ItemCategory] {
        
        return [ItemCategory.fruit, ItemCategory.veggie]
        
    }
    
        
}
