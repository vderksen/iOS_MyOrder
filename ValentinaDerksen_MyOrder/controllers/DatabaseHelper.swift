// Student ID: 153803184
// Student name: Valentina Derksen
// Upated: 2021-03-29

//  DatabaseHelper.swift
//  ValentinaDerksen_MyOrder
//
//  Created by Valya Derksen on 2021-03-28.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    // singleton instance
    private static var shared : DatabaseHelper?
    
    static func getInstance()-> DatabaseHelper {
        if shared != nil {
            // instance already exist
            return shared!
        } else {
            // create a new instance
            return DatabaseHelper(contex : (UIApplication.shared.delegate as! AppDelegate).persistentConteiner.viewContext)
        }
    }
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "Order"
    
    private init (contex : NSManagedObjectContext){
        self.moc = contex
    }
    
    // insert new order into CoreData
    func insertOrder(order : CofeeOrder){
        do {
            // try insert new record
            let newOrder = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! Order
            
            newOrder.type = order.type
            newOrder.size = order.size
            newOrder.quantity = Int32(order.quantity)
            newOrder.id = UUID()
            newOrder.orderDate = Date()
            
            if self.moc.hasChanges{
                try self.moc.save()
                print(#function, "Data inserted successfully")
            }
            
        }catch let error as NSError {
            print(#function, "Could not save data \(error)")
        }
    }
    
    // search order in CoreData
    func searchOrder(orderID : UUID) -> Order? { // return one unique item
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", orderID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do {
            let result = try self.moc.fetch(fetchRequest)
            if result.count > 0{
                return result.first as? Order
            }
        } catch let error as NSError{
            print("Unable to search order \(error)")
        }
        return nil
    }
    
    // update order in CoreData
    func updateOrder(updatedOrder: Order){
        let searchResult = self.searchOrder(orderID: updatedOrder.id! as UUID)
        
        if (searchResult != nil){
            do{
                let orderToUpdate = searchResult!
                
                orderToUpdate.type = updatedOrder.type
                orderToUpdate.size = updatedOrder.size
                orderToUpdate.quantity = updatedOrder.quantity
                
                try self.moc.save()
                print(#function, "Order updated successfully")
            } catch let error as NSError{
                print(#function, "Unable to search order \(error)")
            }
        }
    }
    
    // delete order from CoreData
    func deleteOrder(orderID: UUID) {
        let searchResult = self.searchOrder(orderID: orderID)
        if (searchResult != nil) {
            // matching record found
            do{
                self.moc.delete(searchResult!)
                try self.moc.save()
                print(#function, "Order deleted successfully")
            } catch let error as NSError{
                print("Unable to delete order \(error)")
            }
        }
        
    }
    
    // retrieve all Orders
    func getAllOrders() -> [Order]?{
        let fetchRequest = NSFetchRequest<Order>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "orderDate", ascending: false)]
        
        do{
            // execute request
            let result = try self.moc.fetch(fetchRequest)
            print(#function, "Fetched data: \(result as [Order])")
            // return fetched object after conversion as Todo object
            return result as [Order]
        } catch let error as NSError{
            print("Could not fetch data \(error) \(error.code)")
        }
        return nil
    }
    
}
