//
//  StatisticModel.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 24.02.2025.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}


//struct AppModel {
//    let id = UUID()
//    let title: String
//    let value: String
//}
