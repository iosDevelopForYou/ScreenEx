//
//  SearchBar.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 19.02.2025.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.appColor.secondaryTextColor : Color.appColor.accentAppColor)
            
            TextField("Search by symbol...", text: $searchText)
                .foregroundStyle(Color.appColor.accentAppColor)
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled()
                .overlay(
                    Image(systemName: "xmark.circle")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.appColor.accentAppColor)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.appColor.backgroundAppColor)
                .shadow(
                    color: Color.appColor.accentAppColor.opacity(0.4),
                    radius: 10,
                    x: 0,
                    y: 0
                )
        )
        .padding()
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
