//
//  DetailScreen.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 17.03.2025.
//

import SwiftUI

struct DetailLoadingScreen: View {
    
    @Binding var coin: ExchangeModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailScreen(coin: coin)
            }
        }
       
    }
}

struct DetailScreen: View {
    
    let coin: ExchangeModel
    
    init(coin: ExchangeModel) {
        self.coin = coin
        print("инициализируем детайлскрин для \(coin.name)")
    }
    
    var body: some View {
        
        Text(coin.name)
        
    }
}

#Preview {
    DetailScreen(coin: DeveloperPreview.shared.coin)
}
