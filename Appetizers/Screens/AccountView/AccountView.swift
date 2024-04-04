//
//  AccountView.swift
//  Appetizers
//
//  Created by parth kanani on 26/02/24.
//

import SwiftUI

struct AccountView: View 
{
    @StateObject var viewModel = AccountViewModel()
    @FocusState private var focusedTextField: FormTextField? // it is optional because in the beginning nothing is focused, they can tap something to be focused and another reason when we make it nil that we dissmiss the keyboard.
    
    enum FormTextField // enums are by default hashable
    {
        case firstName, lastName, email
    }

    var body: some View
    {
        NavigationView
        {
            Form
            {
                Section("Personal Info")
                {
                    TextField("First Name", text: $viewModel.user.firstName)
                        .focused($focusedTextField, equals: .firstName) // when this text field is focused, the focus text equals .firstName
                        .onSubmit {
                            focusedTextField = .lastName // when we tap
                        }
                        .submitLabel(.next) // in the keyboard we see next instead of return
                    
                    TextField("Last Name", text: $viewModel.user.lastName)
                        .focused($focusedTextField, equals: .lastName)
                        .onSubmit {
                            focusedTextField = .email
                        }
                        .submitLabel(.next)
                    
                    TextField("Email", text: $viewModel.user.email)
                        .focused($focusedTextField, equals: .email)
                        .onSubmit {
                            focusedTextField = nil // it dismiss the keyboard after we write email and tap on return
                        }
                        .submitLabel(.continue)
                        .keyboardType(.emailAddress) // pulling up the proper keyboard
                        .textInputAutocapitalization(.none) // we don't want any Autocapitalization
                        .autocorrectionDisabled(true)
                    
                    // we have created extension for date range. basically it start out calender from 18 years and see date upto 110 year. so we show date from 1924 to 2006 according to current year 2024.
                    DatePicker("Birthday",
                               selection: $viewModel.user.birthDate,
                               in: Date().oneHundredTenYearsAgo...Date().eighteenYearsAgo,
                               displayedComponents: .date)
                }
                
                Section("Requests") 
                {
                    Toggle("Extra Napkins", isOn: $viewModel.user.extraNapkins)
                    Toggle("Frequent Refills", isOn: $viewModel.user.frequentRefills)
                }
                .tint(.brandPrimary)
                
                Button(action: {
                    viewModel.saveChanges()
                }, label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.mySpecial)
                        .frame(width: 130, height: 30)
                        .overlay {
                            Text("Save Changes")
                                .foregroundStyle(.black)
                        }
                })
                
                Button(action: {
                    viewModel.signedOut()
                }, label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.mySpecial)
                        .frame(width: 130, height: 30)
                        .overlay {
                            Text("Signed Out")
                                .foregroundStyle(.black)
                        }
                })
            }
            .navigationTitle("👤 Account")
            .toolbar(content: {
                ToolbarItem(placement: .keyboard) {
                    Button("Dismiss") { // in keyboard, there is new button named Dismiss
                        focusedTextField = nil
                    }
                }
            })
        }
        .onAppear(perform: {
            viewModel.retrieveUser()
        })
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dissmissButton)
        }
    }
}

#Preview {
    AccountView()
}
