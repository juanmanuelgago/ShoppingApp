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
    var token: String?
    
    private init() {
        AuthenticationManager.shared.authenticate { (response) in
            self.token = response.token
        }
    }
    
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
                    onCompletion(banners, nil)
                }
            }
    }
    
    func getPurchases(onCompletion: @escaping ([ShoppingCart]?, Error?) -> Void) {
        if let token = self.token as String? {
            let bearer = "Bearer " + token
            let requestedURL = URL + "/purchases"
            let headers : HTTPHeaders = ["Authorization": bearer]
            Alamofire.request(requestedURL, method: .get, parameters: nil, headers: headers)
            .validate()
            .responseArray { (response: DataResponse<[ShoppingCart]>) in
                
                guard response.result.isSuccess else {
                    onCompletion(nil, nil)
                    return
                }
                
                if let purchases = response.result.value as [ShoppingCart]? {
                    print("PURCHASES!")
                    print(purchases)
                    print("-------END")
                    onCompletion(purchases, nil)
                }
            }
        } else {
            onCompletion(nil, nil)
        }
    }
    
}
