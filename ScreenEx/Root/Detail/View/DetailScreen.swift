//
//  DetailScreen.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 17.03.2025.
//

import SwiftUI

struct DetailLoadingScreen: View {
    
    @Binding var coin: ExchangeModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailScreen(coin: coin)
            }
        }
       
    }
}

struct DetailScreen: View {
    
    @StateObject private var viewModel: DetailViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 30
    
    init(coin: ExchangeModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
      
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    
                    overviewGrid
                    
                    detailsTitle
                    Divider()
                    
                    detailsGrid
                  
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.coin.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Text(viewModel.coin.symbol.uppercased())
                        .font(.headline)
                        .foregroundStyle(Color.appColor.secondaryTextColor)
                    CoinImage(coin: viewModel.coin)
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailScreen(coin: DeveloperPreview.shared.coin)
    }
}

extension DetailScreen {
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.appColor.accentAppColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(viewModel.overviewStatistics) { stat in
                    StatisticComponent(statistic: stat)
                }
            }
    }
    
    private var detailsTitle: some View {
        Text("Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.appColor.accentAppColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var detailsGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(viewModel.additionalStatistics) { stat in
                    StatisticComponent(statistic: stat)
                }
            }
    }
}
