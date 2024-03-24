//
//  SignUpPage.swift
//  WalletApp
//
//  Created by Vitoroi Daniel on 04.03.2024.
//

import SwiftUI
import AuthenticationServices

struct SignUpPage: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    

    var body: some View {
        VStack(spacing: 0) {

            Text("SIGN UP")
                .font(Font.custom("Nunito", size: 25).weight(.heavy) .bold())
                .tracking(2)
                .lineSpacing(52.50)
                .foregroundColor(Color(red: 0.24, green: 0.40, blue: 0.44))
                .padding(20)

            // HStack for First Name
            HStack {
                Image(systemName: "person.fill")
                    .foregroundColor(.gray)

                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            // HStack for Last Name
            HStack {
                Image(systemName: "person.fill")
                    .foregroundColor(.gray)

                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()

            // HStack for Email
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)

                TextField("Email", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, -5)
            }
            .padding()

            HStack {
                Image(systemName: "phone.fill")
                    .foregroundColor(.gray)

                TextField("Phone", text: $phone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()

            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(.gray)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()

            Text("or use an extraneous accounts")
                .font(Font.custom("Nunito", size: 14).weight(.semibold))
                .multilineTextAlignment(.leading)
                .tracking(1)
                .lineSpacing(16)
                .padding(5)
            
            SignInWithAppleButton(
                           onRequest: { request in
                               // Prepare the request for authorization
                               print("Sign in with Apple requested")
                           },
                           onCompletion: { result in
                               
                           }
                       )
                       .signInWithAppleButtonStyle(.whiteOutline)
                       .frame(width: 150, height: 35)
                       .padding(.top, 20)
                       .onTapGesture {
                           print("Succesfull") // Check if the tap gesture is working
                       }

            
            HStack {
                Spacer()
                Button(action: {
                    // Actions for Google button
                }) {
                    Image("google-icon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 70)
                }
                Spacer()
                
            }
            
            let signInColor = Color(red: 61/255, green: 102/255, blue: 112/255)
            let signUpColor = Color(red: 64/255, green: 76/255, blue: 178/255)
            

            HStack {
                Button(action: {
                    // Actions
                }) {
                    Text("Sign In")
                        .padding()
                        .foregroundColor(.white)
                        .background(signInColor)
                        .cornerRadius(10)
                }
                

                Button(action: {
                    // Action for Sign Up button
                }) {
                    Text("Sign Up")
                        .padding()
                        .foregroundColor(.white)
                        .background(signUpColor)
                        .cornerRadius(10)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(50)
            Spacer()
        }
        .padding(.top, 120)
        .frame(width: 400, height: 900)
        .background(Color(red: 0.95, green: 0.95, blue: 0.96))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SignUpPage()
}
