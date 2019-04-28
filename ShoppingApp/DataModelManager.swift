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
        let avocadoItem = Item(name: "Avocado", price: 10, category: ItemCategory.veggie, smallImage: avocadoImage, bigImage: avocadoImage)
        
        let cucumberImage = UIImage(named: "Cucumber")!
        let cucumberItem = Item(name: "Cucumber", price: 10, category: ItemCategory.veggie, smallImage: cucumberImage, bigImage: cucumberImage)

        let grapefruitSmallImage = UIImage(named: "Grapefruit")!
        let grapefruitBigImage = UIImage(named: "Grapefruit-2")!
        let grapefruitItem = Item(name: "Grapefruit", price: 10, category: ItemCategory.fruit, smallImage: grapefruitSmallImage, bigImage: grapefruitBigImage)
        
        let kiwiSmallImage = UIImage(named: "Kiwi")!
        let kiwiBigImage = UIImage(named: "Kiwi-2")!
        let kiwiItem = Item(name: "Kiwi", price: 10, category: ItemCategory.fruit, smallImage: kiwiSmallImage, bigImage: kiwiBigImage)
        
        let watermelonSmallImage = UIImage(named: "Watermelon")!
        let watermelonBigImage = UIImage(named: "Watermelon")!
        let watermelonItem = Item(name: "Watermelon", price: 10, category: ItemCategory.fruit, smallImage: watermelonSmallImage, bigImage: watermelonBigImage)

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
