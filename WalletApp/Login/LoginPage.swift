//
//  LoginPage.swift
//  WalletApp
//
//  Created by Vitoroi Daniel on 03.03.2024.
//

import SwiftUI


struct LoginPage: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isToggled = false
    @State private var showSignUpPage = false
    
    var body: some View {
        VStack(spacing: 0){
            
            Image("logo")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 150, height: 110)
              .offset(x: 0, y: -20)
            
            Text("SING IN")
                .font(Font.custom("Nunito", size: 30).weight(.heavy) .bold())
                .tracking(2)
                .lineSpacing(52.50)
                .foregroundColor(Color(red: 0.24, green: 0.40, blue: 0.44))
                .padding(20)
            
            HStack {
                Image(systemName: "envelope")
                    .padding(.leading, -5)
                    .foregroundColor(.gray)
                
                TextField("Email", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            
            HStack {
                Image(systemName: "lock")
                    .padding(.leading, 2)
                    .foregroundColor(.gray)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()

            
            Text("Forgot password?")
                .font(Font.custom("Nunito", size: 16).weight(.semibold))
                .multilineTextAlignment(.leading)
                .tracking(1)
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.25, green: 0.30, blue: 0.70))
                .padding()
            
            HStack {
                Text("Enable 2FA authentification")
                    .font(Font.custom("Nunito", size: 16).weight(.semibold))
                    .multilineTextAlignment(.leading)
                    .tracking(1)
                    .lineLimit(16)
                
                Toggle("", isOn: $isToggled)
                    .toggleStyle(CustomToggleStyle())
                    .frame(width: 50, height: 30)
                    .padding(.trailing)
                
                Text(isToggled ? "Yes" : "No")
            }
            .padding()
            
            Spacer()
            
            let customColor = Color(red: 64/255, green: 76/255, blue: 178/255)
            let customColor2 = Color(red: 61/255, green: 102/255, blue: 112/255)
            
            HStack {
                NavigationLink(destination: MainPage()) {
                    Text("Sign In!")
                        .font(Font.custom("Nunito", size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .background(customColor)
                        .cornerRadius(40)
                        .padding(0)
                }
                
                NavigationLink(destination: SignUpPage()) {
                    Text("Sign Up!")
                        .font(Font.custom("Nunito", size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .background(customColor2)
                        .cornerRadius(30)
                        .padding(0)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            
            Spacer()
        }
        .padding(.top, 150)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.95, green: 0.95, blue: 0.96))
            .edgesIgnoringSafeArea(.all)
           
    }
}




#Preview {
    LoginPage()
}
