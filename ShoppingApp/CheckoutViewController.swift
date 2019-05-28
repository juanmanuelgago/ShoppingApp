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
    
    var canCheckout = false
    var shoppingCart = ShoppingCart()
    var items: [Item] = []
    
    // Instances of the picker and the toolbar. Both are created and shown when a cell is selected.
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    // This variable bind the value of the picker that's being selected. It's an optional.
    var pickerValue: Int?
    // This variable gets the instance of the item of the selected cell, when one of those is pressed.
    var selectedItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleCheckoutButton()
        initialConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Shopping Cart"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func initialConfiguration() {
        print("estado del canCheckout?")
        print(canCheckout)
        items = shoppingCart.itemsWithQuantity()
        setTotalPriceLabel()
    }
    
    func setTotalPriceLabel() {
        let totalPrice = shoppingCart.getFinalPrice()
        totalPriceLabel.text = "$" + String(totalPrice)
    }

    // Method to style the Checkout button.
    func styleCheckoutButton() {
        checkoutButton.layer.cornerRadius = checkoutButton.frame.height / 2
        guard canCheckout else {
//            checkoutButton.isHidden = true
            checkoutButton.isEnabled = false
            checkoutButton.alpha = 0.25
            return
        }
    }
    
    // Finishes the checkout process, cleaning the items of shopping bag.
    func popCheckoutPage() {
        shoppingCart.clearItems()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkoutShoppingCart(_ sender: Any) {
        RemoteServiceManager.shared.createPurchase(shoppingCart: shoppingCart) { (success, error) in
            if let _ = error as Error? {
                let alert = UIAlertController(title: "Successful Purchase", message: "Unexpected error while processing the purchase. Please, try again later.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Successful Purchase", message: success, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.popCheckoutPage()
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

extension CheckoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "ItemCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ItemCollectionViewCell
        let quantityOfItem = shoppingCart.getItemQuantity(itemToGet: items[indexPath.row])
        cell.setItemData(item: items[indexPath.row], quantity: quantityOfItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard canCheckout else {
            return
        }
        
        toolBar.removeFromSuperview() // Prevents issue of creating multiple pickers if there's one picker active.
        picker.removeFromSuperview() // Closes the active one, and creates a new one for the last cell touched.
        selectedItem = items[indexPath.row]
    
        // Code for the picker view.
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        // Code for the toolbar, over the picker view.
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = UIBarStyle.default
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    // Handles the detection of the press on the "Done" button in the toolbar.
    // Needs to refresh data, and set the new value in the shopping bag.
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        if let selectedItem = selectedItem as Item?, let pickerValue = pickerValue as Int? {
            shoppingCart.setItemQuantity(itemToSet: selectedItem, newQuantity: pickerValue)
            self.itemCollectionView.reloadData()
            setTotalPriceLabel()
        }
    }
    
}

extension CheckoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2) - 7.5, height: (collectionView.frame.height/2) + 20)
    }
}

extension CheckoutViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // From 1 to 10... needs only ten rows.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    // The values are set to the pickerValue variable.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerValue = row + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 1)
    }
}

