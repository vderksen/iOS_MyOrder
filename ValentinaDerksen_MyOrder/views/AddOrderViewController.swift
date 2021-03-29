// Student ID: 153803184
// Student name: Valentina Derksen
// Upated: 2021-03-29

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
    private var orderList : [Order] = [Order]()
    private let dbHelper = DatabaseHelper.getInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up a picker view to display an array of coffee types
        self.pkrType.dataSource = self
        self.pkrType.delegate = self
    }
    
    // take user inputs and add a single order to the array of orders
    @IBAction func addOrder(){
        
        var type1 : String = ""
        var size1 : String = ""
        var quantity1 : Int = 0
        
        if (tfQuantity.text != "") {
            quantity1 = Int(tfQuantity.text!) ?? 0
            size1 = self.segSize.titleForSegment(at: self.segSize.selectedSegmentIndex)!
            type1 = self.cofeeTypes[self.pkrType.selectedRow(inComponent: 0)]
            
            let newOrder = CofeeOrder(type: type1, size: size1, quantity: quantity1)
            self.dbHelper.insertOrder(order: newOrder)
        }
    }
    
    // set up segue Navigation to AllOrdersTableViewController
    @IBAction func viewOrders(_sender: Any){
        performSegue(withIdentifier: "segueAllOrders", sender: self)
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

