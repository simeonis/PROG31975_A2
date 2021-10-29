//
//  Display.swift
//  Shae_MyOrder
//
//  Created by Shae Simeoni on 2021-09-24.
//  Student #: 991625152
//

import SwiftUI

struct DisplayView: View {
    // @EnvironmentObject var order: Order
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
//            List {
//                ForEach(0..<order.coffeeList.count, id:\.self) { i in
//                    Section(header: Text("Order #\(i + 1)")) {
//                        Text("Type: ").bold() + Text(order.coffeeList[i].kind.rawValue.camelCaseToWord())
//                        Text("Size: ").bold()  + Text(order.coffeeList[i].size.rawValue.camelCaseToWord())
//                        Text("Cups: ").bold() + Text((String)(order.coffeeList[i].cups))
//                    }
//                }
//            }.listStyle(InsetGroupedListStyle())
            
//            .alert(isPresented: $showAlert) {
//                Alert(title: Text("Delete All"),
//                      message: Text("Are you sure you would like to delete all orders?"),
//                      primaryButton: .destructive(Text("Delete All"), action: { order.clearOrders() }),
//                      secondaryButton: .default(Text("Cancel")))
//            }
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
