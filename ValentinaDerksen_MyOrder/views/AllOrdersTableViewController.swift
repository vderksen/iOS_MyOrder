// Student ID: 153803184
// Student name: Valentina Derksen
// Upated: 2021-03-29
// https://github.com/vderksen/iOS_MyOrder

//  AllOrdersTableViewController.swift
//  ValentinaDerksen_MyOrder
//
//  Created by Valya Derksen on 2021-02-18.
//

import UIKit

class AllOrdersTableViewController: UITableViewController {
    
    // an array of added single orders
    private var orderList : [Order] = [Order]()
    private let dbHelper = DatabaseHelper.getInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        // add title on the top of table view
        self.navigationItem.title = "All Coffee Orders"
        self.fetchAllOrders()
    }
    
    private func fetchAllOrders(){
        if(self.dbHelper.getAllOrders() != nil){
            self.orderList = self.dbHelper.getAllOrders()!
            self.tableView.reloadData()
        }else {
            print(#function, "No data received from dbHelper")
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderCell
        
        // Configure the cell...
        if indexPath.row < orderList.count{
            let order = orderList[indexPath.row]
            cell.lblOrderType.text = order.type
            cell.lblOrderSize.text = order.size
            cell.lblOrderQuantity.text = String(order.quantity)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.delete(forRowAtIndexPath: indexPath)
        let edit = self.edit(forRowAtIndexPath: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipe
    }
    
    func delete(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
          // let order = orderList[indexPath.row]
           let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, _) in
              // Perform Delete Action
            if (indexPath.row < self.orderList.count){
                //ask for the confirmation first
                self.deleteOrderFromList(indexPath: indexPath)
            }
           }
           return action
       }
    
    private func deleteOrderFromList(indexPath: IndexPath){
        self.dbHelper.deleteOrder(orderID: self.orderList[indexPath.row].id!)
        self.fetchAllOrders()
    }
       
    func edit(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
           let action  = UIContextualAction(style: .normal, title: "Edit") { (action, view, escaping) in
               // Perform Edit Action
            self.displayCustomAlert(isNewTask: false, indexPath: indexPath, title: "Edit Order", message: "Change quantity")
           }
           return action
       }
    
    private func displayCustomAlert(isNewTask : Bool, indexPath: IndexPath?, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if (indexPath != nil){
            alert.addTextField{(textField: UITextField) in
                textField.text = String(self.orderList[indexPath!.row].quantity)
            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            if let quantityText = alert.textFields?[0].text{
                if (indexPath != nil){
                    self.updateOrderInList(indexPath: indexPath!, quantity: quantityText)
                }
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func updateOrderInList(indexPath: IndexPath, quantity: String){
        self.orderList[indexPath.row].quantity = Int32(quantity)!
        self.dbHelper.updateOrder(updatedOrder: self.orderList[indexPath.row])
        self.fetchAllOrders()
    }
       

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
