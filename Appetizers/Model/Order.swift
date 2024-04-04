//
//  Order.swift
//  Appetizers
//
//  Created by parth kanani on 31/03/24.
//

import SwiftUI

final class Order: ObservableObject
{
    @Published var items: [Appetizer] = []
    
    // when we remove the items from array and because of all the child view are listening to it, our price is updated according to the addition and deletion of items.
    var totalPrice: Double
    {
        // add up all the items of items array
        items.reduce(0) {
            $0 + $1.price
        }
    }
    
    func add(_ appetizer: Appetizer) // by _ we don't need to write parameter name at call site.
    {
        items.append(appetizer)
    }
    
    func deleteItems(at offsets: IndexSet)
    {
        items.remove(atOffsets: offsets)
    }
}


