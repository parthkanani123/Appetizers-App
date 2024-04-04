//
//  Appetizer.swift
//  Appetizers
//
//  Created by parth kanani on 27/02/24.
//

import Foundation

// MARK: - Decodable
// when we get Json from server it will in the form of bytes, so to convert that Json into our model(in this case it is Appetizer object) we need to confirm to Decodable ,if we don't use Decodable we have to conert Json into model manually. so in Appetizer we just retrieve data and receiving we just need to decode it, we don't need to encode it.

// MARK: - Encodable
// when you would need to encode your data is like say we were downloading the appetizers, we were manipulating them like we were changing the name, changing the price and then sending them back up to the server. so before you send it back up to the server that's when you need encodale. becuase before sending data to server, it must be in Json format and Encodable done it behind the scene. so in Appetizer we are not doing any of that so there is no reason to conform encodable. so we are only going to conform to decodable.

// MARK: - Codable
// Codable includes both Decodable + Encodable

struct Appetizer: Decodable,Hashable,Identifiable
{
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageURL: String
    let calories: Int
    let protein: Int
    let carbs: Int
}

struct AppetizerResponse: Decodable
{
    let request: [Appetizer]
}

struct MockData
{
    static let sampleAppetizer = Appetizer(id: 0001,
                                           name: "Test Appetizer",
                                           description: "This is the description for my appetizer. It's yummy ",
                                           price: 9.99,
                                           imageURL: "",
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)
    
    static let appetizers = [sampleAppetizer, sampleAppetizer, sampleAppetizer, sampleAppetizer]
    
    // in orderView we are acceessing mockdata data by forEach, so every element should have different id. so we create 3 dummy item with different.
    static let orderItem1 = Appetizer(id: 0001,
                                           name: "Test Appetizer One",
                                           description: "This is the description for my appetizer. It's yummy ",
                                           price: 9.99,
                                           imageURL: "https://seanallen-course-backend.herokuapp.com/images/appetizers/rainbow-spring-rolls.jpg",
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)
    
    static let orderItem2 = Appetizer(id: 0002,
                                           name: "Test Appetizer Two",
                                           description: "This is the description for my appetizer. It's yummy ",
                                           price: 9.99,
                                           imageURL: "https://seanallen-course-backend.herokuapp.com/images/appetizers/rainbow-spring-rolls.jpg",
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)
    
    static let orderItem3 = Appetizer(id: 0003,
                                           name: "Test Appetizer Three",
                                           description: "This is the description for my appetizer. It's yummy ",
                                           price: 9.99,
                                           imageURL: "https://seanallen-course-backend.herokuapp.com/images/appetizers/rainbow-spring-rolls.jpg",
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)
    
     static let orderItems = [orderItem1, orderItem2, orderItem3]
}
