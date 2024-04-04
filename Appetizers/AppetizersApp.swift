//
//  AppetizersApp.swift
//  Appetizers
//
//  Created by parth kanani on 26/02/24.
//

import SwiftUI

@main
struct AppetizersApp: App 
{
    // we have Order model where we created an array of items for orderView. but we also needed that array in all our views. so we have to initialize in this AppetizersApp so that it can access by all views.
    // we also do that using @Binding but binding property to the long hierarchy like 4 - 5 views is not good practice.
    // so for passing data in 1-2 screen we use binding and for more than 2 screen we use environmentObject.
    
    var order = Order()
    
    var body: some Scene
    {
        WindowGroup {
            AppetizerTabView().environmentObject(order) // we are injecting order into AppetizerTabView's(highest root view - all the 3 views are child view of AppetizerTabView) enviornment so that all the child views of AppetizerTabView have access of this order object.
        }
    }
}
