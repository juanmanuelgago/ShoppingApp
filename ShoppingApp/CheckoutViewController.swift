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
    
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    var pickerValue: Int?
    var selectedItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleCheckoutButton()
        initialConfiguration()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinyViewController = segue.destination as! ShoppingBagViewController
        destinyViewController.shoppingCart.clearItems()
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
        let alert = UIAlertController(title: "Successful Purchase", message: "Everything went OK", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.performSegue(withIdentifier: "RestartSegue", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItem = items[indexPath.row]
    
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = UIBarStyle.default
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
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

extension CheckoutViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerValue = row + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 1)
    }
}

