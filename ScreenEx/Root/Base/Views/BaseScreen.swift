//
//  BaseScreen.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 04.02.2025.
//

import SwiftUI

struct BaseScreen: View {
    
    @State private var goToTheNextScreen: Bool = false
    @State private var showPortfolioScreen: Bool = false
    
    @EnvironmentObject private var viewModel: BaseViewModel
    
    @State private var selectedCoin: ExchangeModel? = nil
    @State private var showDetailScreen: Bool = false
    
    var body: some View {
        
        ZStack {
            //задний фон
            Color.appColor.backgroundAppColor
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioScreen) {
                    PortfolioScreen()
                        .environmentObject(viewModel)
                }
            //слой контента
            VStack {
                baseScreenHeader
          
                BaseStatView(showNextScreen: $goToTheNextScreen)
                
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
        .background(
            NavigationLink(
                destination: DetailLoadingScreen(coin: $selectedCoin),
                isActive: $showDetailScreen,
                label: {
                    EmptyView()
                })
        )
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
                .onTapGesture {
                    if goToTheNextScreen {
                        showPortfolioScreen.toggle()
                    }
                }
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
                        .onTapGesture {
                            goToDetailScreen(coin: coin)
                        }
            }
        }
        .listStyle(.plain)
    }
    
    private var porfolioCoinList: some View {
        List {
            ForEach(viewModel.porfolioCoin) { coin in
                CoinCell(coin: coin, showHoldings: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        goToDetailScreen(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private func goToDetailScreen(coin: ExchangeModel) {
        selectedCoin = coin
        showDetailScreen.toggle()
    }
    
    private var columnsTitles: some View {
        HStack {
            HStack {
                Text("Ticker")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    if viewModel.sortOption == .rank {
                        viewModel.sortOption = .rankReversed
                    } else {
                        viewModel.sortOption = .rank
                    }
                }
            }
            Spacer()
            if goToTheNextScreen {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReversed) ? 1 : 0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        if viewModel.sortOption == .holdings {
                            viewModel.sortOption = .holdingsReversed
                        } else {
                            viewModel.sortOption = .holdings
                        }
                    }
                }
            }
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
            }
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                .onTapGesture {
                    withAnimation(.default) {
                        if viewModel.sortOption == .price {
                            viewModel.sortOption = .priceReversed
                        } else {
                            viewModel.sortOption = .price
                        }
                    }
                }
            
            Button {
                withAnimation(.linear(duration: 2)) {
                    viewModel.reloadData()
                }
            } label: {
                Image(systemName: "arrow.trianglehead.2.counterclockwise")
            }
            .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0), anchor: .center)

        }
        .font(.caption)
        .foregroundStyle(Color.appColor.secondaryTextColor)
        .padding(.horizontal)
    }
}
