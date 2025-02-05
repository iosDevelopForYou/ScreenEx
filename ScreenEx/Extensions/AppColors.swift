//
//  AppColors.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 03.02.2025.

//Объявление: Статические свойства объявляются с использованием ключевого слова static. Это позволяет создать свойство, доступное на уровне типа.
//Для доступа к статическим свойствам используется имя класса или структуры, а не экземпляр.

import Foundation
import SwiftUI

extension Color {
    
    static let appColor = AppColors()
    
}

struct AppColors {
    let accentAppColor = Color("AccentColor")
    let backgroundAppColor = Color("ColorForBackground")
    let colorPricesUp = Color("ColorForPricesUp")
    let colorPricesDown = Color("ColorForPricesDown")
    let secondaryTextColor = Color("ColorForSecondaryText")
}
