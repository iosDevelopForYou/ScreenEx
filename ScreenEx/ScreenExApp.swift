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
    @State private var showLuanchView: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.appColor.accentAppColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.appColor.accentAppColor)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                
                ZStack {
                    BaseScreen()
                        .toolbar(.hidden)
                    
                    ZStack {
                        if showLuanchView {
                            LaunchView(showLaunchView: $showLuanchView)
                                .transition(.move(edge: .leading))
                        }
                    }
                    .zIndex(2)
                }
            }
            .environmentObject(viewModel)
        }
    }
}
