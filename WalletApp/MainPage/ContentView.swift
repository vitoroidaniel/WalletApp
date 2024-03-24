//
//  ContentView.swift
//  WalletApp
//
//  Created by Vitoroi Daniel on 04.03.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.95, green: 0.95, blue: 0.96).ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                    
                    Text("E-WALLET")
                        .font(Font.custom("Nunito", size: 32).weight(.black))
                        .tracking(2)
                        .lineSpacing(52.50)
                        .foregroundColor(Color(red: 0.24, green: 0.40, blue: 0.44))
                    
                    Text("APPLICATION")
                        .font(Font.custom("Nunito", size: 15).weight(.semibold))
                        .tracking(6)
                        .lineSpacing(25)
                        .foregroundColor(Color(red: 0.24, green: 0.40, blue: 0.44))
                    
                    Spacer()
                    
                    // custom color for start now button
                    let startNow = Color(red: 61/255, green: 102/255, blue: 112/255)
                    
                    
                    NavigationLink(destination: LoginPage()) {
                        Text("Start Now!")
                            .font(Font.custom("Nunito", size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(startNow)
                            .cornerRadius(25)
                            .padding(50)
                    }
                    
                    Text("2024. All rights reserved")
                        .font(Font.custom("Nunito", size: 20).weight(.semibold))
                        .lineSpacing(20.02)
                        .foregroundColor(Color(red: 0.24, green: 0.40, blue: 0.44))
                        .padding(.bottom, 80)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

