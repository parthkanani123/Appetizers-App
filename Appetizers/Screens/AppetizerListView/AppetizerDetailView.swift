//
//  AppetizerDetailView.swift
//  Appetizers
//
//  Created by parth kanani on 29/03/24.
//

import SwiftUI

struct AppetizerDetailView: View 
{
    // we don't require to initialize AppetizerDetailView with this order because our view assuming that you have use @EnvironmentObject if something in the enviornment and it's going to pull from it. your app will crash if you don't inject it into the enviornment properly. because if AppetizerDetailView was not in the view heirarchy of AppetizerTabView(because we have use enviornment on it) this would crash.

    @EnvironmentObject var order: Order
    
    let appetizer: Appetizer
    @Binding var isShowingDetail: Bool
    
    var body: some View
    {
        VStack
        {
            // it's dont again downloaded, because when our listView appear it downloaded and then we push it to cache.
            AppetizerRemoteImage(urlString: appetizer.imageURL)
//                .resizable()  // it only go on image that's why we have added it in the AppetizerRemoteImage view
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 225)
            
            VStack
            {
                Text(appetizer.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(appetizer.description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
                
                HStack(spacing: 40)
                {
                    NutritionInfo(title: "Calories", value: "\(appetizer.calories)")
                    NutritionInfo(title: "Carbs", value: "\(appetizer.calories) g")
                    NutritionInfo(title: "Protein", value: "\(appetizer.calories) g")
                }
            }
            
            Spacer()
            
            Button(action: {
                order.add(appetizer)
                isShowingDetail = false // when we click on add to order button we want to dismiss the AppetizerDetailView
            }, label: {
//                APButton(title: "$\(appetizer.price, specifier: "%.2f") - Add to Order")
                Text("$\(appetizer.price, specifier: "%.2f") - Add to Order")
            })
            .modifier(StandardButtonStyle()) // this custom modifier we have created in view folder -> CustomModifiers
//            .buttonStyle(BorderedButtonStyle())
//            .tint(.brandPrimary)
//            .controlSize(.large)
            .padding(.bottom, 30)
        }
        .frame(width: 300, height: 525)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(alignment: .topTrailing) {
            Button(action: {
                isShowingDetail = false
            }, label: {
                XDismissButton()
            })
        }
    }
}

#Preview {
    AppetizerDetailView(appetizer: MockData.sampleAppetizer, isShowingDetail: .constant(true))
}

struct NutritionInfo: View 
{
    let title: String
    let value: String
    
    var body: some View
    {
        VStack(spacing: 5)
        {
            Text(title)
                .bold()
                .font(.caption)
            
            Text(value)
                .foregroundStyle(.gray)
                .fontWeight(.semibold)
                .italic()
        }
    }
}
