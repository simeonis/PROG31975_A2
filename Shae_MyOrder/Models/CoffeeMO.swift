//
//  CoffeeMO.swift
//  Shae_MyOrder
//
//  Created by Shae Simeoni on 2021-10-29.
//

import Foundation
import CoreData

@objc(CoffeeMO)
final class CoffeeMO: NSManagedObject {
    @NSManaged var id: UUID?
    @NSManaged var type : String
    @NSManaged var size : String
    @NSManaged var cups : Int32
    @NSManaged var dateAdded: Date
}

extension CoffeeMO{
    func convertToCoffee() -> Coffee {
        Coffee(
            cID: id ?? UUID(),
            cType: CoffeeType(rawValue: type) ?? CoffeeType.DarkRoast,
            cSize: CoffeeSize(rawValue: size) ?? CoffeeSize.Medium,
            cCups: Int(cups))
    }
}
