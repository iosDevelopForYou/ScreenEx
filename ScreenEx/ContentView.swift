//
//  ContentView.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 03.02.2025.
//

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        
        VStack(spacing: 30) {
//            RoundedRectangle(cornerRadius: 20)
//                .fill(Color.appColor.accentAppColor)
//                .frame(width: 100, height: 100)
//            
//            Capsule()
//                .fill(Color.appColor.backgroundAppColor)
//                .frame(width: 100, height: 100)
//            
//            Circle()
//                .fill(Color.appColor.colorPricesDown)
//                .frame(width: 100, height: 100)
//            
//            Rectangle()
//                .fill(Color.appColor.colorPricesUp)
//                .frame(width: 100, height: 100)
//            
//            RoundedRectangle(cornerRadius: 20)
//                .fill(Color.appColor.secondaryTextColor)
//                .frame(width: 100, height: 100)
            
            Button(action: {
                go()
            }) {
                Text("Button")
            }
        }
        .padding()
    }
    
    func go() {

        // Базовый URL
        let baseURL = "https://api.coingecko.com/api/v3/coins/markets"

        // Параметры запроса
        let queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "order", value: "market_cap_desc"),
            URLQueryItem(name: "per_page", value: "1"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sparkline", value: "true"),
            URLQueryItem(name: "price_change_percentage", value: "24h") // Исправлено на "24h"
        ]

        // Создаем URLComponents для добавления параметров
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = queryItems

        // Получаем итоговый URL
        guard let url = urlComponents.url else {
            fatalError("Could not create URL from components")
        }

        // Выводим итоговый URL для проверки
      //  print("Generated URL: \(url)")

        // Создаем и выполняем запрос
        Task {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "x-cg-demo-api-key": "CG-AYEGNnmyAEXbUiv5fitneLqw"
            ]

            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                // Обрабатываем полученные данные
                 let jsonString = String(decoding: data, as: UTF8.self)
               // print("это здесь \(request.description)" )
                print(jsonString)
//                } else {
//                    print("Could not decode data to string")
//                }
            } catch {
                print("Error fetching data: \(error)")
            }
        }

        
    }
}

#Preview {
    ContentView()
}
