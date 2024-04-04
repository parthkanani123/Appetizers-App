//
//  XDismissButton.swift
//  Appetizers
//
//  Created by parth kanani on 29/03/24.
//

import SwiftUI

struct XDismissButton: View 
{
    var body: some View 
    {
        ZStack
        {
            Circle()
                .frame(width: 25, height: 25)
                .foregroundStyle(.white)
                .opacity(0.6)
            
            Image(systemName: "xmark")
                .imageScale(.medium)
                .frame(width: 44, height: 44)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    XDismissButton()
}
