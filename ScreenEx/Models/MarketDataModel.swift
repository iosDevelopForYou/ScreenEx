//
//  MarketDataModel.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 25.02.2025.
//url request parameters
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

struct MarketDataModel: Codable {
    let data: GlobalData?
}

struct GlobalData: Codable {
  
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
   
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return item.value.formattedWithAbbreviations() + "$"
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return item.value.formattedWithAbbreviations() + "$"
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.addPercentString()
        }
        return ""
    }
}
