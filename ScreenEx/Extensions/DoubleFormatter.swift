//
//  DoubleFormatter.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 10.02.2025.
//

import Foundation

extension Double {
    /// конвертирует значение типа Double в значение Currency с числами после запятой от 2-6
    /// ```
    ///конвертирует 1234.56 в $1,234.56
    ///конвертирует 12.345 в $12.345
    ///конвертирует 0.123456 в $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// конвертирует значение типа Double в значение Currency типа String с числами после запятой от 2-6
    /// ```
    ///конвертирует 1234.56 в "$1,234.56"
    ///конвертирует 12.345 в "$12.345"
    ///конвертирует 0.123456 в "$0.123456"
    /// ```
    func asCurrencyWith6FractionDigits() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "0.00"
    }
    
    /// конвертирует значение типа Double в значениетипа String с 2 числами после запятой
    /// ```
    ///конвертирует 1.23456 в "1.23"
    /// ```
    func fromNumberToString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// конвертирует значение типа Double в значениетипа String с 2 числами после запятой и плюс знак %
    /// ```
    ///конвертирует 1.23456 в "1.23%"
    ///
    func addPercentString() -> String {
        return fromNumberToString() + "%"
    }
}
