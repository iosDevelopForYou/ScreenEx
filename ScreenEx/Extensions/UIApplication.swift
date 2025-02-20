//
//  UIApplication.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 19.02.2025.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
