//
//  Alert.swift
//  Appetizers
//
//  Created by parth kanani on 28/03/24.
//

import SwiftUI

struct AlertItem: Identifiable 
{
    let id = UUID()
    let title: Text
    let message: Text
    let dissmissButton: Alert.Button
}


struct AlertContext 
{
    // MARK: - Netwok Alerts
    static let invalidData      = AlertItem(title: Text("Server Error"),
                                            message: Text("The data received from the server is invalid. Please contact support."),
                                            dissmissButton: .default(Text("OK")))
    
    static let invalidResponse  = AlertItem(title: Text("Server Error"),
                                            message: Text("Inavlid respose from the server. Please try again later or contact support"),
                                            dissmissButton: .default(Text("OK")))
    
    static let invalidURL       = AlertItem(title: Text("Server Error"),
                                            message: Text("There was an issue connecting to the server. If this persists, please contact support."),
                                            dissmissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                            message: Text("Unable to complete your request at this time. Please check your internet connection"),
                                            dissmissButton: .default(Text("OK")))
    
    
    // MARK: - Account Alerts
    
    static let inValidForm = AlertItem(title: Text("Invalid Form"),
                                            message: Text("Please ensure all fields in the form have been filled out"),
                                            dissmissButton: .default(Text("OK")))
    
    static let inValidEmail = AlertItem(title: Text("Invalid Email"),
                                            message: Text("Please ensure your email is correct"),
                                            dissmissButton: .default(Text("OK")))
    
    static let userSaveSuceess = AlertItem(title: Text("Profile Saved"),
                                            message: Text("Your profile information was successfully saved."),
                                            dissmissButton: .default(Text("OK")))
    
    static let invalidUserData = AlertItem(title: Text("Profile Error"),
                                            message: Text("There was an error saving or retrievig your profile."),
                                            dissmissButton: .default(Text("OK")))
    
    static let userSignedOutSucess = AlertItem(title: Text("Signed Out"),
                                            message: Text("You are successfully signed out."),
                                            dissmissButton: .default(Text("OK")))
    
    static let userSignedOutUnSucess = AlertItem(title: Text("Error"),
                                            message: Text("You have not created profile yet"),
                                            dissmissButton: .default(Text("OK")))
}
