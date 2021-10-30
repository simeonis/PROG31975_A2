//
//  OrderView.swift
//  Shae_MyOrder
//
//  Created by Shae Simeoni on 2021-09-24.
//  Student #: 991625152
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    @State private var _selection: Int? = nil
    @State private var _selectedCoffeeType: CoffeeType = CoffeeType.DarkRoast
    @State private var _selectedCoffeeSize: CoffeeSize = CoffeeSize.Medium
    @State private var _numberOfCups: String = ""
    @State private var showAlert: Bool = false
    
    private var numberOfCups : Int { return (Int(self._numberOfCups) ?? 0) }
    
    private func addCoffee() -> Void {
        // Add Coffee to order list
        self.coreDBHelper.addOrder(coffee: Coffee(cType: _selectedCoffeeType, cSize: _selectedCoffeeSize, cCups: numberOfCups))
        
        // Reset selections to default
        _selectedCoffeeType = CoffeeType.DarkRoast
        _selectedCoffeeSize = CoffeeSize.Medium
        _numberOfCups = ""
    }
    
    private func viewOrders() -> Void {
        self._selection = 1
        coreDBHelper.getAllOrders()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: DisplayView(), tag: 1, selection: $_selection) {}
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
                            Image(systemName: "plus")
                                .foregroundColor(Color.white)
                                .padding(0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .font(.system(size: 28))
                        }.buttonStyle(FormButtomStyle())
                    }.listRowInsets(EdgeInsets())
                    
                    .alert(isPresented: $showAlert) {
                        if (numberOfCups > 0) {
                            return Alert(title: Text("Order Added"),
                                  message: Text("Your order has successfully been added."),
                                  dismissButton: .cancel(Text("OK"), action: { self.addCoffee() }))
                        } else {
                            return Alert(title: Text("Invalid Order"),
                                  message: Text("Number of cups must be greater than zero."),
                                  dismissButton: .cancel(Text("OK")))
                        }
                    }
                } // Form
            } // VStack
            .navigationBarItems(trailing: Button("View Orders", action: { self.viewOrders() }))
            .navigationBarTitle("Order", displayMode: .inline)
        } // NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
