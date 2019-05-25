//
//  RemoteServiceManager.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 5/22/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class RemoteServiceManager {
    
    static let shared = RemoteServiceManager()
    let URL = "https://us-central1-ucu-ios-api.cloudfunctions.net"
    
    private init() { }
    
    func getItems(onCompletion: @escaping ([Item]?, Error?) -> Void) {
        let requestedURL = URL + "/products"
        Alamofire.request(requestedURL, method: .get)
            .validate()
            .responseArray { (response: DataResponse<[Item]>) in
                
                guard response.result.isSuccess else {
                    onCompletion(nil, nil)
                    return
                }
                
                if let items = response.result.value as [Item]? {
                    onCompletion(items, nil)
                }
        }
        
    }
    
    func getBanners(onCompletion: @escaping ([ItemBanner]?, Error?) -> Void) {
        let requestedURL = URL + "/promoted"
        Alamofire.request(requestedURL, method: .get)
            .validate()
            .responseArray { (response: DataResponse<[ItemBanner]>) in
                
                guard response.result.isSuccess else {
                    onCompletion(nil, nil)
                    return
                }                
                
                if let banners = response.result.value as [ItemBanner]? {
                    print("obtuve info de banners")
                    print(banners)
                    onCompletion(banners, nil)
                }
            }
    }
    
    func createPurchase() {
        
    }
    
    func getPurchases(onCompletion: @escaping ([Purchase]?, Error?) -> Void) {
        
    }
    
}
