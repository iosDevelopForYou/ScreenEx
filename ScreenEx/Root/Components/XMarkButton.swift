//
//  XMarkButton.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 26.02.2025.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .foregroundStyle(Color.appColor.secondaryTextColor)
                .font(.headline)
        }
    }
}

#Preview {
    XMarkButton()
}
