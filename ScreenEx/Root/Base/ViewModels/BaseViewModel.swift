//
//  BaseViewModel.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 11.02.2025.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    
    @Published var statArray: [StatisticModel] = []
    
    @Published var exchangeCoin: [ExchangeModel] = []
    @Published var porfolioCoin: [ExchangeModel] = []
    
    private let exchangeDataService = MarketDataService()
    
    private let globalDataServise = GlobalDataService()
    
    private let portfolioDataService = PortfolioDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var searchText: String = ""
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        //update exchangeCoin
        $searchText
            .combineLatest(exchangeDataService.$exchangeCoins)
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
        
        // update statArray
        globalDataServise.$marketData
            .map { globalData -> [StatisticModel] in
                
                var stats: [StatisticModel] = []
                
                guard let data = globalData else {
                    return stats
                }
                
                let marketCap = StatisticModel(title: "MarketCap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
                let volume = StatisticModel(title: "24h Volume", value: data.volume)
                let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
                let portfolio = StatisticModel(title: "Portfolio Value", value: "0.00", percentageChange: 0)
                
                stats.append(contentsOf: [
                    marketCap,
                    volume,
                    btcDominance,
                    portfolio
                ])
                return stats
            }
            .sink { [weak self] returnedStats in
                self?.statArray = returnedStats
            }
            .store(in: &cancellables)
        
        // update portfolioCoins
        $exchangeCoin
            .combineLatest(portfolioDataService.$savedEntities)
            .map { coinModels, portfolioEntities -> [ExchangeModel] in
                
                coinModels.compactMap { coin -> ExchangeModel? in
                    guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                        return nil
                    }
                    return coin.updateHoldings(amount: entity.amount)
                }
            }
            .sink { [weak self] returnedCoins in
                self?.porfolioCoin = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    func updatePortfoilio(coin: ExchangeModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
}


