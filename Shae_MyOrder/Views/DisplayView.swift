//
//  Display.swift
//  Shae_MyOrder
//
//  Created by Shae Simeoni on 2021-09-24.
//  Student #: 991625152
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    @State private var showAlert: Bool = false
    
    private func deleteAll() -> Void {
        for order in self.coreDBHelper.orderList {
            self.coreDBHelper.deleteOrder(coffeeID: order.id!)
        }
        
        self.coreDBHelper.orderList.removeAll()
    }
    
    var body: some View {
        VStack {
            if (coreDBHelper.orderList.count > 0) {
                List {
                    ForEach(self.coreDBHelper.orderList.enumerated().map({$0}), id: \.element.self)
                    { i, currentOrder in
                        Section(header: Text("Order #\(coreDBHelper.orderList.count - i)")) {
                            Text("Type: ").bold() + Text(currentOrder.type)
                            Text("Size: ").bold() + Text(currentOrder.size)
                            Text("Cups: ").bold() + Text((String)(currentOrder.cups))
                        }
                    }
                }.listStyle(InsetGroupedListStyle())
                
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Delete All"),
                          message: Text("Are you sure you would like to delete all orders?"),
                          primaryButton: .destructive(Text("Delete All"), action: { self.deleteAll() }),
                          secondaryButton: .default(Text("Cancel")))
                }
            } else {
                Text("You have no orders")
            }
        } // VStack
        .navigationBarItems(trailing:
            Button(action: { showAlert = true }) {
            Image(systemName: "trash")
        })
        .navigationBarTitle("Your Orders")
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView().environmentObject(Order())
    }
}
