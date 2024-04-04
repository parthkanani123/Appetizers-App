//
//  AccountViewModel.swift
//  Appetizers
//
//  Created by parth kanani on 30/03/24.
//

import SwiftUI

final class AccountViewModel: ObservableObject
{
    @AppStorage("user") private var userData: Data? // if it's user's first launch or they have not created profile, it's going to be nil
    @Published var user = User()
    @Published var alertItem: AlertItem?
    
    var isValidForm: Bool
    {
        guard !user.firstName.isEmpty && !user.lastName.isEmpty && !user.email.isEmpty else {
            alertItem = AlertContext.inValidForm
            return false
        }
        
        guard user.email.isValidEmail else { // we have implement isValidEmail in String+Ext file
            alertItem = AlertContext.inValidEmail
            return false
        }
        
        return true
    }
    
    func saveChanges()
    {
        // when we tap on savChanges button first we check all the detail fill up by user is valid then we store that detail on @AppStorage
        guard isValidForm else {
            return
        }
        
        // we are converting our User into data(Encoding), saving that data into @AppStorage
        // in the realistic app we don't have to save user detail in @AppStorage because if user deletes app then AppStorage will clear as well and we lost user's relevent stuff like username, password. so make sure it's not super usefult stuff that you are storing in AppStorage
        do {
            let data = try JSONEncoder().encode(user)
            userData = data
            alertItem = AlertContext.userSaveSuceess
        } catch {
            // if encoding fails it comes into this catch block and usually the encoding fails when you messed up your model like you had typo in some of property of User. so if it fails we alert user.
            alertItem = AlertContext.invalidUserData
        }
    }
    
    func retrieveUser()
    {
        // userData is optional, so first we make sure that there is userdata it's not nil before we try to decode it because what's going to happen if we try to decode it and it's nil, it's going to into our decoding catch block.
        
        // before iOS 16 we do guard let userData = userData, but after iOS 16 not.
        guard let userData else {
            // if there is no userData means fresh launch and in fresh launch we want to show default blank user that blank textfield and all that stuff so we don't want show an error if it's nill. so we would simply return.
            return
        }
        
        // now we have userData so we decode it
        do {
            user = try JSONDecoder().decode(User.self, from: userData)
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }
    
    func signedOut()
    {
        guard isValidForm else {
            alertItem = AlertContext.userSignedOutUnSucess
            return
        }
        
        user.firstName = ""
        user.lastName = ""
        user.email = ""
        user.birthDate = Date()
        user.extraNapkins = false
        user.frequentRefills = false
        userData = nil
        
        alertItem = AlertContext.userSignedOutSucess
    }
}
