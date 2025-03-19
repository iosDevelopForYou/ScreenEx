//
//  CoinDataDetailService.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 18.03.2025.
//

//let url = URL(string: "https://api.coingecko.com/api/v3/coins/bitcoin")!
//var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//let queryItems: [URLQueryItem] = [
//  URLQueryItem(name: "localization", value: "false"),
//  URLQueryItem(name: "tickers", value: "false"),
//  URLQueryItem(name: "market_data", value: "false"),
//  URLQueryItem(name: "community_data", value: "false"),
//  URLQueryItem(name: "developer_data", value: "false"),
//  URLQueryItem(name: "sparkline", value: "false"),
//]
//components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
//
//var request = URLRequest(url: components.url!)
//request.httpMethod = "GET"
//request.timeoutInterval = 10
//request.allHTTPHeaderFields = [
//  "accept": "application/json",
//  "x-cg-demo-api-key": "CG-AYEGNnmyAEXbUiv5fitneLqw"
//]
//
//let (data, _) = try await URLSession.shared.data(for: request)
//print(String(decoding: data, as: UTF8.self))

import Foundation
import Combine

class CoinDataDetailService {
    
    @Published var coinDetails: CoinDataModel? = nil
    
    var coinDetailSubscription: AnyCancellable?
    let coin: ExchangeModel
  
    init(coin: ExchangeModel) {
        self.coin = coin
        getCoinDetails()
    }
    
     func getCoinDetails() {
        
        // Базовый URL
         let baseURL = "https://api.coingecko.com/api/v3/coins/\(coin.id)"
        
        // Параметры запроса
         let queryItems: [URLQueryItem] = [
           URLQueryItem(name: "localization", value: "false"),
           URLQueryItem(name: "tickers", value: "false"),
           URLQueryItem(name: "market_data", value: "false"),
           URLQueryItem(name: "community_data", value: "false"),
           URLQueryItem(name: "developer_data", value: "false"),
           URLQueryItem(name: "sparkline", value: "false"),
         ]
        
        //Создаем URLComponents для добавления параметров
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = queryItems
        
        // Получаем итоговый URL
        guard let url = urlComponents.url else {
            fatalError("Не получилось собрать URL из urlComponents")
        }
        
        // Создаем сам запрос
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
              "accept": "application/json",
              "x-cg-demo-api-key": "CG-AYEGNnmyAEXbUiv5fitneLqw"
            ]
        
         coinDetailSubscription = NetworkManager.downLoad(request: request)
            .decode(type: CoinDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
