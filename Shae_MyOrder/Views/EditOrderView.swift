//
//  EditOrderView.swift
//  Shae_MyOrder
//
//  Created by Shae Simeoni on 2021-10-30.
//

import SwiftUI

struct EditOrderView: View {
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    @State private var _selectedCoffeeType: CoffeeType = CoffeeType.DarkRoast
    @State private var _selectedCoffeeSize: CoffeeSize = CoffeeSize.Medium
    @State private var _numberOfCups: String = ""
    @State private var showAlert: Bool = false
    
    @State var index : Int
    
    private var numberOfCups : Int { return (Int(self._numberOfCups) ?? 0) }
    
    private func updateCoffee() -> Void {
        self.coreDBHelper.orderList[index].type = _selectedCoffeeType.rawValue
        self.coreDBHelper.orderList[index].size = _selectedCoffeeSize.rawValue
        self.coreDBHelper.orderList[index].cups = Int32(numberOfCups)
        self.coreDBHelper.updateOrder(updatedOrder: self.coreDBHelper.orderList[index])
    }
    
    var body: some View {
        VStack {
            if (index >= 0) {
                Form {
                    Section(header: Text("Select Coffee Type").bold()) {
                        Picker("Coffee Type", selection: $_selectedCoffeeType)
                        {
                            ForEach(CoffeeType.allCases) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Select Coffee Size").bold()) {
                        Picker("Coffee Size", selection: $_selectedCoffeeSize)
                        {
                            ForEach(CoffeeSize.allCases) { size in
                                Text(size.rawValue).tag(size)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Number of Cups").bold()) {
                        TextField("Enter Number of Cups", text: $_numberOfCups)
                            .keyboardType(.numberPad)
                            .padding(10)
                    }

                    Section {
                        Button(action: { showAlert = true }) {
                            Image(systemName: "pencil.circle")
                                .foregroundColor(Color.white)
                                .padding(0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .font(.system(size: 28))
                        }.buttonStyle(FormButtomStyle())
                    }.listRowInsets(EdgeInsets())
                    
                    .alert(isPresented: $showAlert) {
                        if (numberOfCups > 0) {
                            return Alert(title: Text("Order Updated"),
                                  message: Text("Your order has successfully been updated."),
                                  dismissButton: .cancel(Text("OK"), action: { self.updateCoffee() }))
                        } else {
                            return Alert(title: Text("Invalid Order"),
                                  message: Text("Number of cups must be greater than zero."),
                                  dismissButton: .cancel(Text("OK")))
                        }
                    }
                } // Form
            } else {
                Text("Invalid order")
            }
        } // VStack
        .navigationBarTitle("Edit Order #\(coreDBHelper.orderList.count - index)")
        .onAppear() {
            if (index >= 0 && index < self.coreDBHelper.orderList.count) {
                let coffee = self.coreDBHelper.orderList[index].convertToCoffee()
                self._selectedCoffeeType = coffee.cType
                self._selectedCoffeeSize = coffee.cSize
                self._numberOfCups = (String)(coffee.cCups)
            }
        }
        .onDisappear(){
            self.coreDBHelper.orderList.removeAll()
            self.coreDBHelper.getAllOrders()
        }
    }
}

struct EditOrderView_Previews: PreviewProvider {
    static var previews: some View {
        EditOrderView(index: -1)
    }
}