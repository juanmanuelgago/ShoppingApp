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
    
    func createPurchase(shoppingCart: ShoppingCart, onCompletion: @escaping (String?, Error?) -> Void) {
        AuthenticationManager.shared.authenticate { (authResponse) in
            let parameters = shoppingCart.createJSON()
            let bearer = "Bearer " + authResponse.token
            let requestedURL = self.URL + "/checkout"
            let headers : HTTPHeaders = [ "Authorization": bearer ]
            Alamofire.request(requestedURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .validate()
                .responseString { response in
                    switch response.result {
                    case .success:
                        if let validMessage = response.result.value as String? {
                            onCompletion(validMessage, nil)
                        }
                    case .failure(let errorFailure):
                        onCompletion(nil, errorFailure)
                    }
            }
        }
    }
    
    func getItems(onCompletion: @escaping ([Item]?, Error?) -> Void) {
        let requestedURL = URL + "/products"
        Alamofire.request(requestedURL, method: .get)
            .validate()
            .responseArray { (response: DataResponse<[Item]>) in
                
                switch response.result {
                case .success:
                    if let items = response.result.value as [Item]? {
                        onCompletion(items, nil)
                    }
                case .failure(let errorFailure):
                    onCompletion(nil, errorFailure)
                }
        }
        
    }
    
    func getBanners(onCompletion: @escaping ([ItemBanner]?, Error?) -> Void) {
        let requestedURL = URL + "/promoted"
        Alamofire.request(requestedURL, method: .get)
            .validate()
            .responseArray { (response: DataResponse<[ItemBanner]>) in
                
                switch response.result {
                    case .success:
                        if let banners = response.result.value as [ItemBanner]? {
                            onCompletion(banners, nil)
                        }
                    case .failure(let errorFailure):
                        onCompletion(nil, errorFailure)
                    
                }
            }
    }
    
    func getPurchases(onCompletion: @escaping ([ShoppingCart]?, Error?) -> Void) {
        AuthenticationManager.shared.authenticate { (authResponse) in
            let requestedURL = self.URL + "/purchases"
            let bearer = "Bearer " + authResponse.token
            let headers : HTTPHeaders = [ "Authorization": bearer ]
            Alamofire.request(requestedURL, method: .get, parameters: nil, headers: headers)
                .validate()
                .responseArray { (response: DataResponse<[ShoppingCart]>) in
                    
                    switch response.result {
                    case .success:
                        if let purchases = response.result.value as [ShoppingCart]? {
                            onCompletion(purchases, nil)
                        }
                    case .failure(let errorFailure):
                        onCompletion(nil, errorFailure)
                    }
                    
            }
        }
    }
}

