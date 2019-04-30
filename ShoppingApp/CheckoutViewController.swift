//
//  CheckoutViewController.swift
//  ShoppingApp
//
//  Created by Juan Manuel Gago on 4/19/19.
//  Copyright © 2019 Juan Manuel Gago. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    var shoppingCart = ShoppingCart()
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleCheckoutButton()
        initialConfiguration()
    }
    
    func initialConfiguration() {
        items = shoppingCart.itemsWithQuantity()
        setTotalPriceLabel()
    }
    
    func setTotalPriceLabel() {
        let totalPrice = shoppingCart.getFinalPrice()
        totalPriceLabel.text = "$" + String(totalPrice)
    }

    func styleCheckoutButton() {
        checkoutButton.layer.cornerRadius = checkoutButton.frame.height / 2
    }
    
    @IBAction func checkoutShoppingCart(_ sender: Any) {
        // TODO: Checkout Button Click Action
    }
}

extension CheckoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "ItemCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ItemCollectionViewCell
        cell.itemDelegate = self
        cell.setItem(item: items[indexPath.row])
        return cell
    }
}

extension CheckoutViewController: ItemCellDelegate {
    
    // Calls the shopping bag instance to increase one, returns the new value. In Add / Subtract methods, refresh the final price label calling the setTotalPriceLabel method.
    func didIncreaseItemQuantity(item: Item) -> String {
        let newValue = shoppingCart.addItem(itemToAdd: item)
        setTotalPriceLabel()
        return String(newValue)
    }
    
    // Calls the shopping bag instance to decrease one, returns the new value.
    func didDecreaseItemQuantity(item: Item) -> String {
        let newValue = shoppingCart.subtractItem(itemToSubtract: item)
        setTotalPriceLabel()
        return String(newValue)
    }
    
    func getItemQuantity(item: Item) -> String {
        let actualValue = shoppingCart.getItemQuantity(itemToGet: item)
        return  String(actualValue)
    }

}

