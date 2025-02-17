//
//  MarketDataService.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 12.02.2025.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var exchangeCoins: [ExchangeModel] = []
    
    var coinSubscription: AnyCancellable?
  
    init() {
        getMarketData()
    }
    
    private func getMarketData() {
        
        // Базовый URL
        let baseURL = "https://api.coingecko.com/api/v3/coins/markets"
        
        // Параметры запроса
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "order", value: "market_cap_desc"),
            URLQueryItem(name: "per_page", value: "250"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sparkline", value: "true"),
            URLQueryItem(name: "price_change_percentage", value: "24")
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
        
        coinSubscription = URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .utility))
            .tryMap { output -> Data in
                
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [ExchangeModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Ошибка - \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedCoins in
                self?.exchangeCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }


    }
}
