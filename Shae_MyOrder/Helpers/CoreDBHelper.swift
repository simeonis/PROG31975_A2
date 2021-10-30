//
//  CoreDBHelper.swift
//  Shae_MyOrder
//
//  Created by Shae Simeoni on 2021-10-29.
//

import Foundation
import CoreData
import UIKit

class CoreDBHelper: ObservableObject{
    
    @Published var orderList = [CoffeeMO]()
    
    //singleton instance (pattern)
    private static var shared : CoreDBHelper?
    
    static func getInstance() -> CoreDBHelper {
        if shared != nil{
            // instance of CoreDBHelper class already exists, so return the same
            return shared!
        }else{
            // there is no existing instance of CoreDBHelper class, so create new and return
            shared = CoreDBHelper(context: PersistenceController.preview.container.viewContext)
            return shared!
        }
    }
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "CoffeeMO"
    
    init(context: NSManagedObjectContext){
        self.moc = context
    }
    
    func addOrder(coffee: Coffee){
        do{
            
            let coffeeToBeInserted = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! CoffeeMO
            
            coffeeToBeInserted.id = UUID()
            coffeeToBeInserted.type = coffee.cType.rawValue
            coffeeToBeInserted.size = coffee.cSize.rawValue
            coffeeToBeInserted.cups = Int32(coffee.cCups)
            coffeeToBeInserted.dateAdded = Date()
            
            if self.moc.hasChanges {
                try self.moc.save()
                print(#function, "Data is saved successfully")
            }
            
        } catch let error as NSError{
            print(#function, "Could not save the data \(error)")
        }
    }
    
    func getAllOrders(){
        let fetchRequest = NSFetchRequest<CoffeeMO>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "dateAdded", ascending: false)]
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            print(#function, "Number of records fetched : \(result.count)")
            self.orderList.removeAll()
            self.orderList.insert(contentsOf: result, at: 0)
            
        } catch let error as NSError{
            print(#function, "Could not fetch data from Database \(error)")
        }
    }
    
    private func searchOrder(coffeeID : UUID) -> CoffeeMO? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", coffeeID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do {
            let result = try self.moc.fetch(fetchRequest)
            if result.count > 0 {
                return result.first as? CoffeeMO
            }
        } catch let error as NSError{
            print(#function, "Unable to search for data \(error)")
        }
        
        return nil
    }
    
    func deleteOrder(coffeeID : UUID){
        let searchResult = self.searchOrder(coffeeID: coffeeID)
        
        if (searchResult != nil){
            // matching object found
            do{
                self.moc.delete(searchResult!)
                
                try self.moc.save()
                objectWillChange.send()
                print(#function, "Data deleted successfully")
            } catch let error as NSError{
                print(#function, "Couldn't delete data \(error)")
            }
        } else {
            print(#function, "No matching record found")
        }
    }
    
    func updateOrder(updatedOrder: CoffeeMO){
        let searchResult = self.searchOrder(coffeeID: updatedOrder.id! as UUID)
        
        if (searchResult != nil){
            //matching object found
            do{
                let orderToUpdate = searchResult!
                
                orderToUpdate.type = updatedOrder.type
                orderToUpdate.size = updatedOrder.size
                orderToUpdate.cups = updatedOrder.cups
                
                try self.moc.save()
                objectWillChange.send()
                print(#function, "Data Updated Successfully")
                
            } catch let error as NSError{
                print(#function, "Unable to update data \(error)")
            }
        } else {
            print(#function, "No matching data found")
        }
    }
}

