//
//  BaseScreen.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 04.02.2025.
//

import SwiftUI

struct BaseScreen: View {
    
    @State private var goToTheNextScreen: Bool = false
    @EnvironmentObject private var viewModel: BaseViewModel
    
    var body: some View {
        
        ZStack {
            //задний фон
            Color.appColor.backgroundAppColor
                .ignoresSafeArea()
            
            //слой контента
            VStack {
                baseScreenHeader
                
                SearchBar(searchText: $viewModel.searchText)
                
                columnsTitles
                
                if !goToTheNextScreen {
                    exchangeCoinList
                        .transition(.move(edge: .leading))
                }
                if goToTheNextScreen {
                    porfolioCoinList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        BaseScreen()
            .toolbar(.hidden)
    }
    .environmentObject(BaseViewModel())
}

extension BaseScreen {
    private var baseScreenHeader: some View {
        HStack {
            CustomButton(iconName: goToTheNextScreen ? "plus.viewfinder" : "info.square.fill")
                .background(
                    CustomButtonAnimation(animate: $goToTheNextScreen)
                )
            Spacer()
            Text(goToTheNextScreen ? "Portfolio" : "Exchange")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.appColor.accentAppColor)
                .animation(.none)
            Spacer()
            CustomButton(iconName: "arrowtriangle.forward")
                .rotationEffect(Angle(degrees: goToTheNextScreen ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        goToTheNextScreen.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var exchangeCoinList: some View {
        List {
            ForEach(viewModel.exchangeCoin) { coin in
                CoinCell(coin: coin, showHoldings: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var porfolioCoinList: some View {
        List {
            ForEach(viewModel.porfolioCoin) { coin in
                CoinCell(coin: coin, showHoldings: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnsTitles: some View {
        HStack {
            Text("Ticker")
            Spacer()
            if goToTheNextScreen {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.appColor.secondaryTextColor)
        .padding(.horizontal)
    }
}
