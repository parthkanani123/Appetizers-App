//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by parth kanani on 28/03/24.
//

import SwiftUI

// @MainActor -> on line no 58
@MainActor final class AppetizerListViewModel: ObservableObject
{
    @Published var appetizers: [Appetizer] = [] // your view model and ObservableObject needs to broadcast when it changes and what we are setting up on our AppetizerListView is we are setting up to listen to those broadcasts that is changing so in order to broadcast the change use the property wrapper @Published
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var isShowingDetail = false
    @Published var selectedAppetizer: Appetizer?
    
    // our network manager getting appetizers and then we are settung this appetizer (self.appetizers = appetizers) and because this is ObservableObject and this is @Published whenever this array of appetizers changes, it's going to broadcast it's change and back to our AppetizerListView, because we have @StateObject var viewModel, now we are listening for those changes.
    
    // MARK: - Old way
    
    /*
    func getAppetizers()
    {
        isLoading = true
        NetworkManager.shared.getAppetizers { result in
            
            // we are on background thread right now with our networking and all UI updates should be on main thread. Usually in UIKit you could set data on background thread, that's fine. but swiftUI is different because setting the data is triggering a UI update, so this need to happen on main thread, so you have to get on the main thread.
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let appetizers):
                    self.appetizers = appetizers
                    
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                        
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                        
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                        
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
     */
    
    // MARK: - new way - iOS 15
    
    // in old we we manually putting updation on main thread, in this new async await method we don't have to do that because now we have something called actors. so by marking our view model @MainActor, basically anything that happens in this viewModel that's UI relateed will be rerouted to the main thread. basically it as same as DispatchQueue.main.async. except it abstracts it into the language and does it for you.
    func getAppetizers()
    {
        isLoading = true
        
        Task
        {
            // this is in do try catch block because NetworkManager.shared.getAppetizers() throws error. so we have to handle errors accordingly. // we put this do try catch block into Task{} to put it in a async context
            do {
                appetizers = try await NetworkManager.shared.getAppetizers()
                isLoading = false
            } catch {
                
                // if that error in this catch block that is apError of type APError, cool let;s do some stuff here
                if let apError = error as? APError  {
                    
                    // in networkManager we are only throwing invalidURL and invalidData but i want to keep these other cases ,in case that ever changes in the future.
                    switch apError {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                } else { // if it's not of type APError
                    alertItem = AlertContext.invalidResponse // invalidResponse is generic error placeholder
                }
            }
        }
    }
}
