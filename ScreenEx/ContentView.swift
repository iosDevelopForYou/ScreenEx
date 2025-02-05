//
//  ContentView.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 03.02.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack(spacing: 30) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.appColor.accentAppColor)
                .frame(width: 100, height: 100)
            
            Capsule()
                .fill(Color.appColor.backgroundAppColor)
                .frame(width: 100, height: 100)
            
            Circle()
                .fill(Color.appColor.colorPricesDown)
                .frame(width: 100, height: 100)
            
            Rectangle()
                .fill(Color.appColor.colorPricesUp)
                .frame(width: 100, height: 100)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.appColor.secondaryTextColor)
                .frame(width: 100, height: 100)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
