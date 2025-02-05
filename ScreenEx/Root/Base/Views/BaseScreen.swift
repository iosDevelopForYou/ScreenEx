//
//  BaseScreen.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 04.02.2025.
//

import SwiftUI

struct BaseScreen: View {
    
    @State private var goToTheNextScreen: Bool = false
    
    var body: some View {
       
        ZStack {
            //задний фон
            Color.appColor.backgroundAppColor
                .ignoresSafeArea()
            
            //слой контента
            VStack {
                baseScreenHeader
           
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
}
