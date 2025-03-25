//
//  Date.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 24.03.2025.
//

import Foundation

extension Date {
    
    //"2025-01-20T09:11:54.494Z"
    init(coingekoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coingekoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func shortDescriptionDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
