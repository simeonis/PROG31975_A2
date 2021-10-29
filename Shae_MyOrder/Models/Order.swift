//
//  Order.swift
//  Shae_MyOrder
//
//  Created by Shae Simeoni on 2021-09-24.
//  Student #: 991625152
//

import Foundation

class Order : ObservableObject {
    @Published var coffeeList : [Coffee] = []
    
    func clearOrders() -> Void {
        coffeeList.removeAll()
    }
}
