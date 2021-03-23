// Student ID: 153803184
// Student name: Valentina Derksen

//  AddOrderViewController.swift
//  ValentinaDerksen_MyOrder
//
//  Created by Valya Derksen on 2021-02-17.
//

import UIKit

class AddOrderViewController: UIViewController {
    
    @IBOutlet var pkrType : UIPickerView!
    @IBOutlet var segSize : UISegmentedControl!
    @IBOutlet var tfQuantity : UITextField!
    
    // an array of items to display in picker view
    let cofeeTypes = ["Americano", "Cappuccino", "Latte", "Mocca", "Espresso"]
    
    // an array of added single orders
    var orderList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up a picker view to display an array of coffee types
        self.pkrType.dataSource = self
        self.pkrType.delegate = self
    }
    
    // take user inputs and add a single order to the array of orders
    @IBAction func addOrder(){
        
        var type : String = ""
        var size : String = ""
        var quantity : Int = 0
        var order : String = ""
        
        if (tfQuantity.text != "") {
            quantity = Int(tfQuantity.text!) ?? 0
            size = self.segSize.titleForSegment(at: self.segSize.selectedSegmentIndex)!
            type = self.cofeeTypes[self.pkrType.selectedRow(inComponent: 0)]
            print(#function, "Order: \(quantity) \(size) \(type)")
            
            // save user input for a single order as a String
            order = String("\(quantity) \(size) \(type)")
            print(order)
            
            // add single order to an array of orders
            orderList.append(order)
            print(orderList)
        }
    }
    
    // set up segue Navigation to AllOrdersTableViewController
    @IBAction func viewOrders(_sender: Any){
        performSegue(withIdentifier: "segueAllOrders", sender: self)
    }
 
    // and pass array of added orders to AllOrdersTableViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! AllOrdersTableViewController
        destVC.orderCellList = self.orderList
    }

}

extension AddOrderViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cofeeTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cofeeTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(#function, "Selected Type of Cofee: \(self.cofeeTypes[row])")
    }
    
}

