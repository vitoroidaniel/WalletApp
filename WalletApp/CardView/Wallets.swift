//
//  Wallets.swift
//  WalletApp
//
//  Created by Vitoroi Daniel on 21.03.2024.
//

import SwiftUI

struct Wallets: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red: 36/255, green: 57/255, blue: 114/255))
                .frame(height: 1000)
            
            Text("My Wallets")
                .font(.title)
                .foregroundColor(.white)
                .position(x: UIScreen.main.bounds.width - 195, y: 150) // Top center position
            
            Button(action: {
                // Action for plus button
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
            }
            .position(x: UIScreen.main.bounds.width - 50, y: 150) // Top right position
            
            VStack(spacing: 30) { // Adding a vertical stack to position the rectangles
                Spacer().frame(height: 0) // Move rectangles higher by reducing the spacer height
                
                // First rectangle
                WalletRectangle(imageName: "creditcard.fill", cardNumber: generateCardNumber(), date: "04/26", amount: 350.0)
                
                // Second rectangle
                WalletRectangle(imageName: "creditcard.fill", cardNumber: generateCardNumber(), date: "05/27", amount: 420.0)
                
                // Third rectangle
                WalletRectangle(imageName: "creditcard.fill", cardNumber: generateCardNumber(), date: "06/28", amount: 620.0)
                
                // Fourth rectangle
                WalletRectangle(imageName: "creditcard.fill", cardNumber: generateCardNumber(), date: "07/29", amount: 280.0)
            }
            .padding(.top, -30) // Adding horizontal padding to the VStack
        }
    }
    
    func generateCardNumber() -> String {
        var cardNumber = "**** "
        for _ in 0..<1 {
            cardNumber += "\(Int.random(in: 1000...9999)) "
        }
        return cardNumber.trimmingCharacters(in: .whitespaces)
    }
}

struct WalletRectangle: View {
    var imageName: String
    var cardNumber: String
    var date: String
    var amount: Double
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.blue)
                .font(.system(size: 30))
                .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text(cardNumber)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text("Exp. Date: \(date)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("$\(String(format: "%.2f", amount))")
                .foregroundColor(.black)
                .font(.headline)
                .padding(.trailing)
        }
        .padding()
        .frame(width: 343, height: 96)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.10), radius: 20)
    }
}

#if DEBUG
struct Wallets_Previews: PreviewProvider {
    static var previews: some View {
        Wallets()
    }
}
#endif
