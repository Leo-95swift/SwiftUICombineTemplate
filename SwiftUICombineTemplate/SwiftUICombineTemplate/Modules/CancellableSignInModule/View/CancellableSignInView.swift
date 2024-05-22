//
//  CancellableSignInView.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 21.05.24.
//

import SwiftUI

struct CancellableSignInView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let bankLogo = "bankLogo"
    }
    
    @StateObject var viewModel = CancellableSignInViewModel()
    @State var emailValidation = ""
    @State var passwordValidation = ""

    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.signInBackground
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                    .frame(height: 80)
                
                Image(Constants.bankLogo)
                
                Spacer()
                    .frame(height: 60)
                
                VStack(spacing: 5) {
                    emailView
                    passwordView
                }
                
                Text(viewModel.validationStatus)
                
                Spacer()
                    .frame(height: 40)
                
                signInButtonView
                
                Spacer()
                    .frame(height: 40)
                
                resetButton
                
                Spacer()
            }
        }

    }
    
    // MARK: Visual Components
    
    private var emailView: some View {
        HStack {
            TextField("Your email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(8)

            Text(viewModel.emailValidation)
        }
        .padding()
        .frame(height: 50)
    }
    
    private var passwordView: some View {
        HStack {
            TextField("Your password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(8)
            Text(viewModel.passwordValidation)
        }
        .padding()
        .frame(height: 50)
    }
    
    private var signInButtonView: some View {
        Button {
            
        } label: {
            Text("Sign In")
                .font(.title)
                .bold()
        }
        .disabled(!viewModel.isSignInButtonEnabled)
        .foregroundColor(
            viewModel.isSignInButtonEnabled
            ? .signInButtonEnabled
            : .gray
        )
    }
    
    private var resetButton: some View {
        Button {
            viewModel.cancellable?.cancel()
            viewModel.validationStatus = "Вход отменён"
        } label: {
            Text("Reset")
        }
        .foregroundColor(.blue)
    }
    
}

#Preview {
    CancellableSignInView()
}
