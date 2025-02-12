//
//  BaseViewModel.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 11.02.2025.
//

import Foundation

class BaseViewModel: ObservableObject {
    
    @Published var exchangeCoin: [ExchangeModel] = []
    @Published var porfolioCoin: [ExchangeModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.exchangeCoin.append(DeveloperPreview.shared.coin)
            self.porfolioCoin.append(DeveloperPreview.shared.coin)
        }
    }
}
