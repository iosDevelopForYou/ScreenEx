//
//  GlobalDataService.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 25.02.2025.
//

/*
//let url = URL(string: "https://api.coingecko.com/api/v3/global")!
//var request = URLRequest(url: url)
//request.httpMethod = "GET"
//request.timeoutInterval = 10
//request.allHTTPHeaderFields = [
//  "accept": "application/json",
//  "x-cg-demo-api-key": "CG-AYEGNnmyAEXbUiv5fitneLqw"
//]
//
//let (data, _) = try await URLSession.shared.data(for: request)
//print(String(decoding: data, as: UTF8.self))
*/

import Foundation
import Combine

class GlobalDataService {
    
    @Published var marketData: GlobalData?
    
    var marketDataSubscription: AnyCancellable?
  
    init() {
        getGlobalData()
    }
    
    func getGlobalData() {
        // Получаем итоговый URL
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            fatalError("Не получилось использовать URL в классе GlobalDataService")
        }
        
        // Создаем сам запрос
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "x-cg-demo-api-key": "CG-AYEGNnmyAEXbUiv5fitneLqw"
        ]
        
        marketDataSubscription = NetworkManager.downLoad(request: request)
            .decode(type: MarketDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
    
}
