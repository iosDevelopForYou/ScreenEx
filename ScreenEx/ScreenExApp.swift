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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.appColor.accentAppColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.appColor.accentAppColor)]
    }
    
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
