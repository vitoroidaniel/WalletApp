//
//  MainPage.swift
//  WalletApp
//
//  Created by Vitoroi Daniel on 06.03.2024.
//

import SwiftUI

struct MainPage: View {
    @State private var showMenu = false
    @State private var menuButtonFrame: CGRect = .zero
    
    var body: some View {
        VStack(spacing: 0) {
            // Top bar with "All wallets" and user icon
            ZStack {
                Rectangle()
                    .fill(Color(red: 36/255, green: 57/255, blue: 114/255))
                    .frame(height: 250)
                VStack {
                    HStack {
                        Menu {
                            Button(action: {
                            // Handle New Album
                            }) {
                            Label("Profile", systemImage: "person.crop.circle")
                            }
                            Button(action: {
                            // Handle New Folder
                            }) {
                            Label("Sign In", systemImage: "person.fill.checkmark")
                        }
                            Button(action: {
                            // Handle New Shared Album
                        }) {
                            Label("Sign Up", systemImage: "person.fill.badge.plus")
                            }
                            Button(action: {
                            // Handle New Shared Album
                        }) {
                            Label("Exit", systemImage: "figure.walk.departure")
                            }
                        }
                        label: {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.white)
                            
                            // Change color as needed
                        }
                        .padding(.top, 0)
                        .padding(.leading, 20)
                        Spacer()
                        Text("All wallets")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        
                        NavigationLink(destination: CardDetails()) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color(red: 168/255, green: 173/255, blue: 221/255))
                                .padding(.trailing)
                                .imageScale(.large)
                        }
                    }
                    .padding(.horizontal, 20)
                    Text("$24 858.59")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    Text("total balance")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(red: 168/255, green: 173/255, blue: 221/255))
                        .padding(.horizontal, 5)
                }
                .padding(-10)
            }
            
            // Cards and transactions list
            ScrollView {
                VStack(spacing: 16) {
                    CardView(title: "This week", 
                             subtitle: "07 Jule - 14 Jule",
                             income: "$1487.12",
                             spending: "$2695.05")
                        .padding(.horizontal, 16)
                    TransactionListView()
                        .frame(maxWidth: .infinity) 
                        // Align to center
                        .padding(.horizontal, 16)
                }
                .padding(0)
            }
            
            // Tab bar
            TabBarView()
                .padding(.top, 8)
        }
        .edgesIgnoringSafeArea(.top)
        .overlay(
            menuContent()
                .opacity(showMenu ? 1 : 0)
                .offset(x: menuButtonFrame.minX - 80, y: menuButtonFrame.minY + 30)
                //.animation(.easeInOut(duration: 0.3))
        )
    }
}

struct menuContent: View {
    var body: some View {
        VStack(alignment: .leading) {
            Button("Option 1") {
                // Handle Option 1
            }
            Button("Option 2") {
                // Handle Option 2
            }
            Button("Option 3") {
                // Handle Option 3
            }
        }
        .padding(0)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct CardView: View {
    @State private var selectedOption = "This week"
    let options = ["This day", "This week", "This month", "This year"]
    
    let title: String
    let subtitle: String
    let income: String
    let spending: String
    
    var body: some View {
        ZStack {
            // Blue rectangle background
            Rectangle()
                .fill(Color(red: 36/255, green: 57/255, blue: 114/255))
                .frame(height: 100)
                .cornerRadius(12)
            
            // Rectangle containing income and spending
            VStack {
                HStack {
                    // Replace static text with Picker
                    Picker(selection: $selectedOption, label: Text("")) {
                        ForEach(options, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(.white)
                    
                    Spacer()
                    Text(subtitle)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(red: 148/255, green: 175/255, blue: 182/255))
                }
                .padding()
                
                // Chart and income/spending indicators would be here
                
                HStack {
                    Text("Income")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(red: 148/255, green: 175/255, blue: 182/255))
                    Spacer()
                    Text("Spending")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(red: 148/255, green: 175/255, blue: 182/255))
                }
                .padding(.horizontal, 10)
                
                
                HStack {
                    Text(income)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(red: 61/255, green: 102/255, blue: 112/255))
                    Spacer()
                    Text(spending)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(red: 61/255, green: 102/255, blue: 112/255))
                }
                .padding(.horizontal, 5)
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
        }
        .padding(0)
    }
}


struct TransactionListView: View {
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<10) { _ in
                TransactionRow()
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}

struct TransactionRow: View {
    let transactionNames = ["Food", "Fuel", "Shopping", "Entertainment", "Utilities", "Transportation"]
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd/MM/yyyy"
        return formatter
    }()
    
    var body: some View {
        let amount = Double.random(in: 1.0...100.0)
        let isExpense = Bool.random()
        let transactionName = transactionNames.randomElement() ?? "Unknown"
        let amountString = String(format: "%.2f", isExpense ? -amount : amount)
        let date = Date()
        
        HStack {
            Image(systemName: isExpense ? "arrow.down.circle" : "arrow.up.circle")
                .imageScale(.large)
            VStack(alignment: .leading) {
                Text(transactionName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(isExpense ? .red : .green)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("$\(amountString)")
                    .font(.system(size: 16))
                    .foregroundColor(isExpense ? .red : .green)
                Text(dateFormatter.string(from: date))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(red: 148/255, green: 175/255, blue: 182/255))
            }
        }
        .padding()
    }
}



struct TabBarView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: "house.fill")
                    .imageScale(.large)
                Text("Dashboard")
            }
            Spacer()
            VStack {
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                Text("Analytics")
                
            }
            Spacer()
            VStack {
                NavigationLink(destination: CardDetails()) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.black)
                        .imageScale(.large)
                    }
                .padding(0)
                Text("Add wallet")
                }
            Spacer()
            VStack {
                NavigationLink(destination: Wallets()){
                    Image(systemName: "wallet.pass.fill")
                        .foregroundColor(.black)
                        .imageScale(.large)
                }
                .padding(0)
                Text("Wallets")
            }
            Spacer()
            VStack {
                Image(systemName: "person.fill")
                    .imageScale(.large)
                Text("Profile")
            }
            Spacer()
        }
        .font(.subheadline)
        .padding(-2)
        .shadow(radius: 10)
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
