//
//  CoinImageDataService.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 18.02.2025.
//

import Foundation
import SwiftUI
import Combine

class CoinImageDataService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: ExchangeModel
    
    init(coin: ExchangeModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        
      
        let baseURL = coin.image
        let urlComponents = URLComponents(string: baseURL)!
        guard let url = urlComponents.url else {
            fatalError("Не получилось собрать URL в классе CoinImageDataService")
        }
        let request = URLRequest(url: url)
       
        
        imageSubscription = NetworkManager.downLoad(request: request)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
