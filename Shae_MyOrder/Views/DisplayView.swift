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
    @State private var _selection: Int? = nil
    @State private var showDelAlert: Bool = false
    @State private var selectedIndex : Int = -1
    
    private func selectedColor(index : Int) -> Color {
        return self.selectedIndex == index ? Color.white : Color.black
    }
    
    private func orderNumber(index : Int) -> Int {
        return self.coreDBHelper.orderList.count - index
    }
    
    private func deleteOrder() -> Void {
        // Button should always be disabled if no order is selected,
        // making this guard redundant.
        if (selectedIndex >= 0 && selectedIndex < self.coreDBHelper.orderList.count) {
            self.coreDBHelper.deleteOrder(coffeeID: self.coreDBHelper.orderList[selectedIndex].id!)
            self.coreDBHelper.orderList.remove(at: selectedIndex)
        }
    }
    
    var body: some View {
        VStack {
            if (coreDBHelper.orderList.count > 0) {
                NavigationLink(destination: EditOrderView(index: selectedIndex), tag: 2, selection: $_selection) {}
                List {
                    ForEach(self.coreDBHelper.orderList.enumerated().map({$0}), id: \.element.self)
                    { i, currentOrder in
                        Section(header: Text("Order #\(orderNumber(index: i))")) {
                            // Coffee Type
                            Text("Type: ").bold().foregroundColor(selectedColor(index: i)) +
                            Text(currentOrder.type).foregroundColor(selectedColor(index: i))
                            // Coffee Size
                            Text("Size: ").bold().foregroundColor(selectedColor(index: i)) +
                            Text(currentOrder.size).foregroundColor(selectedColor(index: i))
                            // Coffee Cups
                            Text("Cups: ").bold().foregroundColor(selectedColor(index: i)) +
                            Text((String)(currentOrder.cups)).foregroundColor(selectedColor(index: i))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.selectedIndex = i
                        }.listRowBackground(self.selectedIndex == i ? Color(red: 0/255, green: 110/255, blue: 230/255) : Color.white)
                    }
                }.listStyle(InsetGroupedListStyle())
            } else {
                NavigationLink(destination: EditOrderView(index: selectedIndex), tag: 2, selection: $_selection) {}
                Text("You have no orders")
            }
        }// VStack
        .navigationBarItems(trailing:
            HStack {
                // Edit Button
                Button(action: { _selection = 2 }) {
                    Image(systemName: "pencil")
                }.padding().disabled(selectedIndex < 0)
                
                // Delete Button
                Button(action: { showDelAlert = true }) {
                    Image(systemName: "trash")
                }.disabled(selectedIndex < 0)
                .alert(isPresented: $showDelAlert) {
                    Alert(title: Text("Delete Order"),
                          message: Text("Are you sure you would like to delete Order #\(orderNumber(index: selectedIndex))?"),
                          primaryButton: .destructive(Text("Delete"), action: { self.deleteOrder() }),
                          secondaryButton: .default(Text("Cancel")))
                }
            }
        )
        .navigationBarTitle("Your Orders")
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
