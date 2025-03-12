//
//  VibroManager.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 11.03.2025.
//

import Foundation
import SwiftUI

class VibroManager {
    
    static private var generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
