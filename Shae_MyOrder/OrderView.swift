//
//  OrderView.swift
//  Shae_MyOrder
//
//  Created by Shae Simeoni on 2021-09-24.
//  Student #: 991625152
//

import SwiftUI

struct OrderView: View {
    @StateObject var order: Order = Order()
    @State private var _selection: Int? = nil
    @State private var _selectedCoffeeKind: Coffee.Kind = Coffee.Kind.DarkRoast
    @State private var _selectedCoffeeSize: Coffee.Size = Coffee.Size.Medium
    @State private var _numberOfCups: String = ""
    @State private var showAlert: Bool = false
    
    private var numberOfCups : Int { return (Int(self._numberOfCups) ?? 0) }
    
    private func addCoffee() -> Void {
        // Add Coffee to order list
        order.coffeeList.append(Coffee(kind: _selectedCoffeeKind, size: _selectedCoffeeSize, cups: numberOfCups))
        
        // Reset selections to default
        _selectedCoffeeKind = Coffee.Kind.DarkRoast
        _selectedCoffeeSize = Coffee.Size.Medium
        _numberOfCups = ""
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: DisplayView(), tag: 1, selection: $_selection) {}
                Form {
                    Section(header: Text("Select Coffee Type").bold()) {
                        Picker("Coffee Type", selection: $_selectedCoffeeKind)
                        {
                            ForEach(Coffee.Kind.allCases) { type in
                                Text(type.rawValue.camelCaseToWord()).tag(type)
                            }
                        }
                    }
                    
                    Section(header: Text("Select Coffee Size").bold()) {
                        Picker("Coffee Size", selection: $_selectedCoffeeSize)
                        {
                            ForEach(Coffee.Size.allCases) { type in
                                Text(type.rawValue.camelCaseToWord()).tag(type)
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
            .navigationBarItems(trailing: Button("View Orders", action: { self._selection = 1 }))
            .navigationBarTitle("Order", displayMode: .inline)
        } // NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(order)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
