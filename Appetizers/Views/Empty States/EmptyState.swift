//
//  EmptyState.swift
//  Appetizers
//
//  Created by parth kanani on 30/03/24.
//

import SwiftUI

struct EmptyState: View 
{
    let imageName: String
    let message: String
    
    var body: some View
    {
        ZStack
        {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack
            {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
                Text(message)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .offset(y: -50) // we use it because we want to push image and text little bit up.
        }
    }
}

#Preview {
    EmptyState(imageName: "empty-order", message: "This is our test message, \n i am making it little long for testing")
}
