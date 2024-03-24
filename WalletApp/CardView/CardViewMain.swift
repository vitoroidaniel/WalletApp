//
//  ContentView.swift
//  TestWalletApp
//
//  Created by Vitoroi Daniel on 17.03.2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct Transaction: Identifiable, Codable {
    var id = UUID()
    var description: String
    var amount: Double
    var type: TransactionType
    
    enum TransactionType: String, Codable {
        case ferry
        case bus
        case airplane
        case fuel
        case withdraw
        
        var imageName: String {
            switch self {
            case .ferry:
                return "ferry"
            case .bus:
                return "bus"
            case .airplane:
                return "airplane"
            case .fuel:
                return "fuelpump"
            case .withdraw:
                return "creditcard"
            }
        }
    }
}

struct CardDetailsView: View {
    let bankName: String
    let cardNumber: String
    let expirationDate: String
    
    var body: some View {
        VStack {
            Text("Bank Name: \(bankName)")
            Text("Card Number: \(cardNumber)")
            Text("Expiration Date: \(expirationDate)")
            
        }
    }
}

struct AdditionalCardDetailsView: View {
    
    var beneficiary: String
    var iban: String
    var swift: String
    var bankDetails: String
    
    // Document details
    var accountStatement: String = "January 2024 Statement"
    var accountConfirmation: String = "Confirmation of Account"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(.blue)
                        Text("Beneficiary:")
                            .font(.headline)
                    }
                    Text(beneficiary)
                        .font(.body)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "number.circle.fill")
                            .foregroundColor(.blue)
                        Text("IBAN:")
                            .font(.headline)
                    }
                    Text(iban)
                        .font(.body)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundColor(.blue)
                        Text("SWIFT:")
                            .font(.headline)
                    }
                    Text(swift)
                        .font(.body)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "building.columns.fill")
                            .foregroundColor(.blue)
                        Text("Bank Name and Address:")
                            .font(.headline)
                    }
                    Text(bankDetails)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(.blue)
                        Text("Hints:")
                            .font(.headline)
                    }
                    Text("Use these details to receive your salary and transfers from Euro bank accounts.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .italic()
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "doc.text.fill")
                            .foregroundColor(.blue)
                        Text("Account Statement:")
                            .font(.headline)
                    }
                    Text(accountStatement)
                        .font(.body)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(systemName: "doc.text.fill")
                            .foregroundColor(.blue)
                        Text("Account Confirmation:")
                            .font(.headline)
                    }
                    Text(accountConfirmation)
                        .font(.body)
                }
                .padding(.horizontal)
                
                Divider()
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Card Details")
        .navigationBarItems(trailing: Button(action: {
            // Action to close the view or navigate to another screen
        }) {
            Text("Close")
        })
        .padding(.bottom, 50)
    }
}

struct CardDetails: View {
    @State private var cards: [Card] = []
    @State private var selectedCardIndex: Int?
    @State private var isHalfwayScroll = false
    @State private var showCardDetails = false // Added state variable
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(cards.indices, id: \.self) { index in
                            CardViewMain(card: cards[index])
                                .id(index)
                                .onTapGesture {
                                    selectedCardIndex = index // Update selectedCardIndex when a card is tapped
                                }
                        }
                    }
                    .padding(.horizontal, 20)
                    .onChange(of: isHalfwayScroll) { halfway in
                        if halfway {
                            guard let index = selectedCardIndex else { return }
                            scrollView.scrollTo(index, anchor: .center)
                        }
                    }
                    .onAppear {
                        selectedCardIndex = 0
                    }
                }
                .padding(.top, 50)
                .onChange(of: selectedCardIndex) { newIndex in
                    if let index = newIndex {
                        let totalCards = cards.count
                        let halfwayIndex = totalCards / 2
                        isHalfwayScroll = index > halfwayIndex
                    }
                }
            }
            
            if let selectedIndex = selectedCardIndex, cards.indices.contains(selectedIndex) {
                VStack {
                    Text("Transactions")
                        .font(.headline)
                        .padding()
                    
                    List {
                        if !cards.isEmpty {
                            ForEach(cards[selectedIndex].transactions) { transaction in
                                TransactionRowView(transaction: transaction)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    // Display balance of the selected card
                    Text("Balance: $\(String(format: "%.2f", cards[selectedIndex].balance))")
                        .font(.headline)
                        .padding()
                }
            }
            
            Spacer()
        }
        .overlay(
            HStack {
                Spacer()
                Button(action: {
                    let newCard = generateRandomCard()
                    cards.append(newCard)
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
                .foregroundColor(.blue)
                .padding(.trailing, 20)
                
                Button(action: {
                    // Toggle the showCardDetails state variable
                    showCardDetails.toggle()
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
                .foregroundColor(.blue)
                .padding(.trailing, 20)
                
                Button(action: {
                    if let selectedIndex = selectedCardIndex {
                        cards.remove(at: selectedIndex)
                        if cards.isEmpty {
                            selectedCardIndex = nil
                        } else if selectedIndex >= cards.count {
                            selectedCardIndex = cards.count - 1
                        }
                    }
                }) {
                    Image(systemName: "trash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
                .foregroundColor(.red)
                .padding(.trailing, 20)
            }
            .padding(.top, 20)
            .padding(.trailing, 20),
            alignment: .topTrailing
        )
        .sheet(isPresented: $showCardDetails) {
            // Present additional card details view when showCardDetails is true
            if let selectedIndex = selectedCardIndex {
                AdditionalCardDetailsView(beneficiary: cards[selectedIndex].beneficiary, iban: cards[selectedIndex].iban, swift: cards[selectedIndex].swift, bankDetails: cards[selectedIndex].bankDetails)
            }
        }
    }

    func generateRandomCard() -> Card {
        let bankName = "Revolut"
        let part1 = String(Int.random(in: 1000...9999))
        let part2 = String(Int.random(in: 1000...9999))
        let part3 = String(Int.random(in: 1000...9999))
        let part4 = String(Int.random(in: 1000...9999))

        let cardNumber = "\(part1) \(part2) \(part3) \(part4)"

        let expirationDate = "\(Int.random(in: 1...12))/\(Int.random(in: 24...31))"
        
        // Generate random balance for the card
        let balance = Double.random(in: 500.0...1000.0)
        
        let transactions = [Transaction(description: "Ferry, Travel", amount: -300.00, type: .ferry),
                            Transaction(description : "Transport, Bus", amount: -25.00, type: .bus),
                            Transaction(description: "Travel", amount: -400.00, type: .airplane),
                            Transaction(description: "Fuel, Maxol", amount: -100.00, type: .fuel),
                            Transaction(description: "Withdraw", amount: 300.00, type: .withdraw)]
        return Card(bankName: bankName, cardNumber: cardNumber, expirationDate: expirationDate, transactions: transactions, balance: balance)
    }
}

struct Card: Identifiable, Codable {
    var id = UUID()
    var bankName: String
    var cardNumber: String
    var expirationDate: String
    var transactions: [Transaction]
    var balance: Double
    var beneficiary: String = "John Doe" // Added beneficiary property
    var iban: String = "ABCD1234567890" // Added iban property
    var swift: String = "EFGH1234" // Added swift property
    var bankDetails: String = "Random Bank, Address Line 1, Address Line 2" // Added bankDetails property
}

struct CardViewMain: View {
    let card: Card
    @State private var isFlipped = false
    
    var body: some View {
        ZStack {
            if isFlipped {
                CardBackView(bankName: card.bankName, cardNumber: card.cardNumber, expirationDate: card.expirationDate)
            } else {
                CardFrontView(cardNumber: card.cardNumber)
            }
        }
        .rotation3DEffect(
            .degrees(isFlipped ? 360 : 0),
            axis: (x: 0.0, y: 0.0, z: 0.0)
        )
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.isFlipped.toggle()
            }
        }
    }
}

struct CardFrontView: View {
    let cardNumber: String
    
    var body: some View {
        let gradient = LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0/255, green: 0/255, blue: 51/255), // Dark Blue
                Color(red: 102/255, green: 0/255, blue: 102/255), // Dark Violet
                Color(red: 102/255, green: 0/255, blue: 0/255), // Dark Red
                Color(red: 102/255, green: 0/255, blue: 51/255) // Dark Pink
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        
        return VStack {
            HStack {
                Spacer()
                Text("Visa")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.trailing, 20)
            }
            Spacer()
            HStack {
                Text(maskCardNumber(cardNumber))
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
        .background(gradient)
        .cornerRadius(20)
        .padding()
        .frame(width: 350, height: 250)
    }
    
    private func maskCardNumber(_ cardNumber: String) -> String {
        let lastFour = String(cardNumber.suffix(4))
        let masked = String(repeating: "*", count: cardNumber.count - 15)
        return masked + " " + lastFour
    }
}

struct CardBackView: View {
    let bankName: String
    let cardNumber: String
    let expirationDate: String
    
    var body: some View {
        let gradient = LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0/255, green: 0/255, blue: 51/255), // Dark Blue
                Color(red: 102/255, green: 0/255, blue: 102/255), // Dark Violet
                Color(red: 102/255, green: 0/255, blue: 0/255), // Dark Red
                Color(red: 102/255, green: 0/255, blue: 51/255) // Dark Pink
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        
        return VStack {
            HStack {
                Spacer()
                Text(bankName)
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.trailing, 20)
            }
            Spacer()
            VStack(alignment: .leading) {
                Spacer()
                Text("Card Number:")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(cardNumber)
                    .foregroundColor(.white)
                Spacer()
                Text("Expiry Date:")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(expirationDate)
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Text("CVV")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .padding()
        }
        .background(gradient)
        .cornerRadius(20)
        .padding()
        .frame(width: 350, height: 250)
    }
}


struct TransactionRowView: View {
    let transaction: Transaction
    @State private var showDetails = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: transaction.type.imageName)
                    .foregroundColor(.blue)
                    .padding(.trailing, 5)
                Text(transaction.description)
                    .foregroundColor(.primary)
                Spacer()
                Text("$\(String(format: "%.2f", transaction.amount))")
                    .foregroundColor(transaction.amount < 0 ? .red : .green)
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
                    .onTapGesture {
                        showDetails.toggle()
                    }
            }
            .padding(.horizontal)
            
            if showDetails {
                TransactionDetailView(transaction: transaction)
                    .padding(.horizontal)
            }
        }
    }
}

import SwiftUI
import MapKit

struct TransactionDetailView: View {
    let transaction: Transaction
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.0105, longitude: 28.8638), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Location: ")
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: false, userTrackingMode: .none, annotationItems: [transaction]) { item in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: 47.0105, longitude: 28.8638), tint: .red)
            }
            .frame(height: 150)
            .cornerRadius(10)
            .onTapGesture {
                DispatchQueue.global().async {
                    openMaps()
                }
            }
            Text("Time/Date: ") + Text("2024-03-18 10:15")
            Text("Amount: ") + Text("$\(String(format: "%.2f", transaction.amount))")
            Text("Bank: ") + Text("Revolut")
            Text("Country: ") + Text("Ireland")
            Text("County: ") + Text("Dublin")
        }
        .foregroundColor(.black)
        .padding(2)
    }
    
    private func openMaps() {
        let coordinate = CLLocationCoordinate2D(latitude: 47.0105, longitude: 28.8638)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = "Chisinau"
        mapItem.openInMaps()
    }
}



struct CardViewMain_Previews: PreviewProvider {
    static var previews: some View {
        CardDetails()
    }
}
