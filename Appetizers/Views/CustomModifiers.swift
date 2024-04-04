//
//  CustomModifiers.swift
//  Appetizers
//
//  Created by parth kanani on 31/03/24.
//

import SwiftUI

// we have created this custom modifier because we are using it multiple times in detailView and in orderView. so rather than write 3 lines under button we can simply write .modifier(StandardButtonStyle())
struct StandardButtonStyle: ViewModifier
{
    func body(content: Content) -> some View
    {
        content
            .buttonStyle(BorderedButtonStyle())
            .tint(.brandPrimary)
            .controlSize(.large)
    }
}
