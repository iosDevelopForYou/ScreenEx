//
//  ChartView.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 21.03.2025.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    
    private let lineColor: Color
    
    private let startDate: Date
    private let endDate: Date
    
    @State private var percentage: CGFloat = 0
    
    init(coin: ExchangeModel) {
        data = coin.sparklineIn7D?.price ?? []
        minY = data.min() ?? 0
        maxY = data.max() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.appColor.colorPricesUp : Color.appColor.colorPricesDown
        
        endDate = Date(coingekoString: coin.lastUpdated ?? "")
        startDate = endDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 250)
                .background(chartBG)
                .overlay(chartYAxis.padding(.horizontal, 6), alignment: .leading)
            chartDateLabel
                .padding(.horizontal, 6)
        }
        .font(.caption)
        .foregroundStyle(Color.appColor.secondaryTextColor)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2)) {
                    percentage = 1.0
                }
            }
        }
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.shared.coin)
}


extension ChartView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0.0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(1), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 10)
          
        }
    }
    
    private var chartBG: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabel: some View {
        HStack {
            Text(startDate.shortDescriptionDateString())
            Spacer()
            Text(endDate.shortDescriptionDateString())
        }
    }
}

