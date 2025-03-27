//
//  InfoScreen.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 26.03.2025.
//

import SwiftUI

struct InfoScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    let appleURL = URL(string: "https://www.apple.com")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    let developerGitHub = URL(string: "https://github.com/iosDevelopForYou")!
    
    var body: some View {
        
        NavigationStack {
            
            List {
                infoSection
                coinGeckoSection
                developerSection
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Info")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(dismiss: _dismiss)
                }
            }
        }
    }
}

#Preview {
    InfoScreen()
}

extension InfoScreen {
    private var infoSection: some View {
        Section {
            
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("Данное приложение разрабатывалось с использованием архитектуры MVVM а так же фреймворка Combine и CoreData")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.appColor.accentAppColor)
            }
            .padding(.vertical)
            Link("Посетите официальный сайт Apple", destination: appleURL)
                .foregroundStyle(Color.blue)
            
        } header: {
            Text("Описание приложения")
        }
    }
    
    private var coinGeckoSection: some View {
        Section {
            
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                Text("В качестве провайдера рыночных данных в данном приложении использовался сайт https://www.coingecko.com \nОбязательно посетите данный сайт, чтобы получить достоверную информацию")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.appColor.accentAppColor)
            }
            .padding(.vertical)
            Link("Наш провайдер биржевой информации", destination: coinGeckoURL)
                .foregroundStyle(Color.blue)
            
        } header: {
            Text("Провайдер рыночных данных")
        }
    }
    
    private var developerSection: some View {
        Section {
            
            VStack(alignment: .leading) {
                Image("myFoto")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(50)
                Text("Яразрабатывал это приложение днем и ночью, и то что получилось вы можете посмотреть по ссылке в моем аккаунте GitHub")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.appColor.accentAppColor)
            }
            .padding(.vertical)
            Link("Мой аккаунт на GitHub", destination: developerGitHub)
                .foregroundStyle(Color.blue)
            
        } header: {
            Text("О разработчике")
        }
    }
}
