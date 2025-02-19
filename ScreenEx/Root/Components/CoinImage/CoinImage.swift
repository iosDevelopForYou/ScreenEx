//
//  CoinImage.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 18.02.2025.
//

import SwiftUI

struct CoinImage: View {
    
    @StateObject var viewModel: CoinImageViewModel
    
    init(coin: ExchangeModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack{
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.appColor.secondaryTextColor)
            }
        }
    }
}

#Preview {
    CoinImage(coin: DeveloperPreview.shared.coin)
}
