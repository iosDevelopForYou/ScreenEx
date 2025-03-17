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
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOptions = .holdings
    
    private let exchangeDataService = MarketDataService()
    private let globalDataServise = GlobalDataService()
    private let portfolioDataService = PortfolioDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    enum SortOptions {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        //update exchangeCoin
        $searchText
            .combineLatest(exchangeDataService.$exchangeCoins, $sortOption)
            .map { text, startingCoins, sortOption -> [ExchangeModel] in
                
                guard !text.isEmpty else {
                    switch sortOption {
                    case .rank, .holdings:
                        return startingCoins.sorted(by: {$0.rank < $1.rank})
                    case .rankReversed, .holdingsReversed:
                        return startingCoins.sorted(by: {$0.rank > $1.rank})
                    case .price:
                        return startingCoins.sorted(by: {$0.currentPrice > $1.currentPrice})
                    case .priceReversed:
                        return startingCoins.sorted(by: {$0.currentPrice < $1.currentPrice})
                    }
                }
                
                let lowercasedText = text.lowercased()
                
                // фильтрация массива на основе текстфилда
                let filteredCoins = startingCoins.filter { coin -> Bool in
                    return coin.name.lowercased().contains(lowercasedText) ||
                           coin.symbol.lowercased().contains(lowercasedText) ||
                           coin.id.lowercased().contains(lowercasedText)
                }
                
                // фильтрация на основе сортировочных опций
                switch sortOption {
                case .rank, .holdings:
                    return filteredCoins.sorted(by: {$0.rank < $1.rank})
                case .rankReversed, .holdingsReversed:
                    return filteredCoins.sorted(by: {$0.rank > $1.rank})
                case .price:
                    return filteredCoins.sorted(by: {$0.currentPrice > $1.currentPrice})
                case .priceReversed:
                    return filteredCoins.sorted(by: {$0.currentPrice < $1.currentPrice})
                }
            }
            .sink { [weak self] returnedCoins in
                self?.exchangeCoin = returnedCoins
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
                guard let self = self else { return }
                self.porfolioCoin = self.sortPorfolioCoin(coin: returnedCoins)
            }
            .store(in: &cancellables)
        
        // update statArray
        globalDataServise.$marketData
            .combineLatest($porfolioCoin)
            .map { globalData, portfolioCoin -> [StatisticModel] in
                
                var stats: [StatisticModel] = []
                
                guard let data = globalData else {
                    return stats
                }
                
                let marketCap = StatisticModel(title: "MarketCap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
                let volume = StatisticModel(title: "24h Volume", value: data.volume)
                let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
                
                let portfolioValue =
                portfolioCoin
                    .map({ $0.currentHoldingsValue })
                    .reduce(0, +)
                
                let previousValues =
                portfolioCoin
                    .map { coin -> Double in
                        // Текущее значение монеты
                        let currentValue = coin.currentHoldingsValue
                        
                        // Процентное изменение цены за последние 24 часа
                        let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                        
                        // Вычисление предыдущего значения
                        let previousValue = currentValue / (1 + percentChange)
                        return previousValue
                    }
                    .reduce(0, +)
                
                let percentageChange = ((portfolioValue - previousValues) / previousValues) * 100
                
                let portfolio = StatisticModel(
                    title: "Portfolio Value",
                    value: portfolioValue.asCyrruncyWith2decimals(),
                    percentageChange: percentageChange)
                
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
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
     
    }
    
    func updatePortfoilio(coin: ExchangeModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        exchangeDataService.getMarketData()
        globalDataServise.getGlobalData()
        VibroManager.notification(type: .success)
    }
    
    private func sortPorfolioCoin(coin: [ExchangeModel]) -> [ExchangeModel] {
        
        switch sortOption {
        case .holdings:
            return coin.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coin.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coin
        }
    }
}


