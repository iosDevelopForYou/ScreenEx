//
//  ScreenExApp.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 03.02.2025.
//

import SwiftUI

@main
struct ScreenExApp: App {
    
    @StateObject private var viewModel = BaseViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                BaseScreen()
                    .toolbar(.hidden)
            }
            .environmentObject(viewModel)
        }
    }
}
