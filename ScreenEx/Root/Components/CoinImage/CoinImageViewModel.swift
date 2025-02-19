//
//  CoinImageViewModel.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 18.02.2025.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: ExchangeModel
    private let dataService: CoinImageDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: ExchangeModel) {
        self.coin = coin
        self.dataService = CoinImageDataService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
