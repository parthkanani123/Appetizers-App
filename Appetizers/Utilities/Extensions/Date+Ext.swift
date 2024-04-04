//
//  Date+Ext.swift
//  Appetizers
//
//  Created by parth kanani on 01/04/24.
//

import Foundation

extension Date
{
    var eighteenYearsAgo: Date
    {
        Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    }
    
    var oneHundredTenYearsAgo: Date
    {
        Calendar.current.date(byAdding: .year, value: -100, to: Date())!
    }
}
