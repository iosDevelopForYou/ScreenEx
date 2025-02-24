//
//  BaseViewModel.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 11.02.2025.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    
    @Published var exchangeCoin: [ExchangeModel] = []
    @Published var porfolioCoin: [ExchangeModel] = []
    
    private let dataService = MarketDataService()
    var cancellables = Set<AnyCancellable>()
    
    @Published var searchText: String = ""
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        $searchText
            .combineLatest(dataService.$exchangeCoins)
            .map { text, startingCoins -> [ExchangeModel] in
                
                guard !text.isEmpty else {
                    return startingCoins
                }
                
                let lowercasedText = text.lowercased()
                
                let filteredCoins = startingCoins.filter { coin -> Bool in
                    return coin.name.lowercased().contains(lowercasedText) ||
                           coin.symbol.lowercased().contains(lowercasedText) ||
                           coin.id.lowercased().contains(lowercasedText)
                }
                return filteredCoins
            }
            .sink { [weak self] returnedCoins in
                self?.exchangeCoin = returnedCoins
            }
            .store(in: &cancellables)
            
    }
}


