//
//  DetailViewModel.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 18.03.2025.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDataDetailService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: ExchangeModel) {
        self.coinDetailService = CoinDataDetailService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
                print("полученные индивидуальные данные для монеты - \(String(describing: returnedCoinDetails))")
            }
            .store(in: &cancellables)
         
    }
}
