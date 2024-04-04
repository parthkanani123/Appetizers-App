//
//  AppetizerListView.swift
//  Appetizers
//
//  Created by parth kanani on 26/02/24.
//

import SwiftUI

struct AppetizerListView: View 
{
    // @StateObject :-  A property wrapper type that instantiates an observable object
    // @StateObject     -> use this on creation / INIT
    // @ObservedObject  -> use this for subviews
    // if you are initializing your view model use @StateObject
    // if you are passing the view model in from parent view because you needed data from that view use @ObservedObject
    @StateObject var viewModel = AppetizerListViewModel()
    
    var body: some View
    {
        ZStack
        {
            NavigationStack
            {
                List(viewModel.appetizers) { appetizer in
                    
                   AppetizerListCell(appetizer: appetizer)
//                        .listRowSeparator(.hidden)
//                        .listSectionSeparatorTint(.brandPrimary)
                        .onTapGesture {
                            viewModel.selectedAppetizer = appetizer
                            viewModel.isShowingDetail = true
                        }
                }
                .scrollIndicators(.hidden)
                .navigationTitle("🍟 Appetizers")
                .listStyle(.plain)
                .disabled(viewModel.isShowingDetail ? true : false) // when the detailView is on the list, we can't scroll, or do any stuff on list
            }
//            .onAppear(perform: {
//                viewModel.getAppetizers()
//            })
            .task { // it is similar to onAppear, it's basically meant for specifically viewModel.getAppetizers(), if user navigates away from the screen before our network call completes, it automatically cancels the network call. it is tailor made for making a network call when the view loads
                viewModel.getAppetizers()
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            
            if viewModel.isShowingDetail {
                AppetizerDetailView(appetizer: viewModel.selectedAppetizer!,
                                    isShowingDetail: $viewModel.isShowingDetail)
            }
             
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.brandPrimary)
                    .scaleEffect(2) // we double the size of spinner
            }
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dissmissButton)
        })
    }
}

#Preview {
    AppetizerListView()
}
