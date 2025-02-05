//
//  CustomButton.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 04.02.2025.
//

import SwiftUI

struct CustomButton: View {

    let iconName: String

    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.appColor.accentAppColor)
            .frame(width: 55, height: 55)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color.appColor.backgroundAppColor)
            )
            .shadow(color: Color.appColor.accentAppColor.opacity(0.4),
                    radius: 10,
                    x: 0,
                    y: 0)
            .padding()
    }
}

#Preview {
    Group {
        CustomButton(iconName: "info.square")
        
        CustomButton(iconName: "plus.viewfinder")
            .colorScheme(.dark)
    }
}
