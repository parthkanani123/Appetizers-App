//
//  ContentView.swift
//  Appetizers
//
//  Created by parth kanani on 26/02/24.
//

import SwiftUI

struct AppetizerTabView: View 
{
    @EnvironmentObject var order: Order
    
    // to switch between light and dark mode in simulator use :- command + shift + A
    var body: some View
    {
        TabView
        {
            AppetizerListView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
            
            OrderView()
                .tabItem {
                    Label("Order", systemImage: "bag")
                }
                .badge(order.items.count)
        }
//        .accentColor(.brandPrimary) // now we have accent color in assets folder so we did not need to write it here.
        // when we tap on home/account/order it's change to green
    }
}


//#Preview {
//    AppetizerTabView()
//}
