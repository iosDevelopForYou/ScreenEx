//
//  PortfolioScreen.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 26.02.2025.
//

import SwiftUI

struct PortfolioScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var viewModel: BaseViewModel
    @State private var selectedCoin: ExchangeModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBar(searchText: $viewModel.searchText)
                    
                    coinListHorizontal
                    
                    if selectedCoin != nil {
                        portfolioInfo
                    }
                }
            }
            .navigationTitle(Text("Edit Portfolio"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(dismiss: _dismiss)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveToolBarButton
                }
            }
            .onChange(of: viewModel.searchText) { oldValue, newValue in
                if newValue == "" {
                    removeSelection()
                }
            }
        }
        
    }
}

#Preview {
    PortfolioScreen()
        .environmentObject(BaseViewModel())
}


extension PortfolioScreen {
    var coinListHorizontal: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.searchText.isEmpty ? viewModel.porfolioCoin : viewModel.exchangeCoin) { coin in
                    CoinPortfolio(coin: coin)
                        .frame(width: 80)
                        .padding(6)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(selectedCoin?.id == coin.id ?  Color.appColor.accentAppColor : Color.clear, lineWidth: 1)
                        )
                }
            }
            .padding(.vertical)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoin(coin: ExchangeModel) {
        
        selectedCoin = coin
        
       if let portfolioCoin = viewModel.porfolioCoin.first(where: { $0.id == coin.id }),
          let amount = portfolioCoin.currentHoldings {
           quantityText = "\(amount)"
       } else {
           quantityText = ""
       }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInfo: some View {
        VStack {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6FractionDigits() ?? "")
            }
            Divider()
            HStack {
                Text("Porfolio amount:")
                Spacer()
                TextField("Type amount here", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith6FractionDigits())
            }
        }
        .padding()
        .font(.headline)
    }
    
    private var saveToolBarButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .foregroundStyle(Color.appColor.accentAppColor)
                .opacity(showCheckmark ? 1 : 0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("save".uppercased())
                    .foregroundStyle(Color.appColor.accentAppColor)
            }
            .opacity (
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1 : 0
            )
        }
    }
    
    private func saveButtonPressed() {
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        //логика сохранения в портфолио
        viewModel.updatePortfoilio(coin: coin, amount: amount)
        
        //показать галочку
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelection()
        }
        
        //скрытие виртаульной клавиатуры
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelection() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}
