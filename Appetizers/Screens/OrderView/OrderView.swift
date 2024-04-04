//
//  OrderView.swift
//  Appetizers
//
//  Created by parth kanani on 26/02/24.
//

import SwiftUI

struct OrderView: View 
{
    @EnvironmentObject var order: Order
    @State var isShowingOrderPlacedAlert = false
    
    var body: some View
    {
        NavigationView
        {
            ZStack
            {
                VStack
                {
                    // we are going to implement swipe to delete in list. and onDelete modifier works on forEach, not on list because list doesn't have onDelete modifier. so we don't initialize list with data, id and all that stuff. we have to put forEach inside the list.
                    List
                    {
                        ForEach(order.items) { appetizer in
                            AppetizerListCell(appetizer: appetizer)
                        }
                        .onDelete(perform: order.deleteItems)
                    }
                    .listStyle(.plain)
                    
                    Button(action: {
                        isShowingOrderPlacedAlert = true
                    }, label: {
//                        APButton(title: "$\(order.totalPrice, specifier: "%.2f") - Place order")
                        Text("$\(order.totalPrice, specifier: "%.2f") - Place order")
                    })
                    .modifier(StandardButtonStyle())
                    .padding(.bottom, 25)
                }
                
                if order.items.isEmpty {
                    EmptyState(imageName: "empty-order", message: "You have no items in your order. \n Please add an appetizer!")
                }
            }
            .alert(isPresented: $isShowingOrderPlacedAlert, content: {
                Alert(title: Text("Placed"),
                      message: Text("Your order placed successfully"),
                      dismissButton: .default(Text("OK")))
            })
            .navigationTitle("🧾 Orders")
        }
    }
    
    
}

//#Preview {
//    OrderView()
//}
