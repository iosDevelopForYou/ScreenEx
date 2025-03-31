//
//  CoinCell.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 07.02.2025.
//

import SwiftUI

struct CoinCell: View {
    
    let coin: ExchangeModel
    let showHoldings: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldings {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
        .background(
            Color.appColor.backgroundAppColor.opacity(0.001)
        )
    }
}

#Preview {
    CoinCell(coin: DeveloperPreview.shared.coin, showHoldings: true)
}

extension CoinCell {
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.appColor.secondaryTextColor)
                .frame(minWidth: 30)
            CoinImage(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.appColor.accentAppColor)
        }
    }
    
    private var centerColumn: some View {
        VStack {
            Text(coin.currentHoldingsValue.asCurrencyWith6FractionDigits())
                .bold()
            Text((coin.currentHoldings ?? 0).fromNumberToString())
        }
        .foregroundStyle(Color.appColor.accentAppColor)
    }
    
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6FractionDigits())
                .bold()
                .foregroundStyle(Color.appColor.accentAppColor)
            Text((coin.priceChangePercentage24H?.addPercentString() ?? "none" ))
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.appColor.colorPricesUp :
                    Color.appColor.colorPricesDown
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        
    }
}
