//
//  User.swift
//  Appetizers
//
//  Created by parth kanani on 30/03/24.
//

import Foundation

// here we confirm to Codable, because we need Decodable and Encodable. so to store our user into @AppStorage, first we have to convert our user object into data and then store that data into @AppStorage, and for this conversion we require Encodable to encode user into data. so the flow goes like this : User -> Data -> @AppStorage. and same thing when we want to retrieve user from @AppStorage we have to convert that data into User object and for that conversion we require Decodable to decode data into User. that's why we confirm to Codable.

struct User: Codable
{
    var firstName       = ""
    var lastName        = ""
    var email           = ""
    var birthDate       = Date()
    var extraNapkins    = false
    var frequentRefills = false
}
