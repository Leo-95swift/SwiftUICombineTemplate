//
//  GuessTheNumberView.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 22.05.24.
//

import SwiftUI
import Combine

struct GuessTheNumberView: View {
    
    // MARK: - Constats
    
    enum Constants {
        static let gameTitle = "Try to guess my number"
        static let textFieldPlaceholder = "Enter number"
    }
    @StateObject private var viewModel = GuessTheNumberViewModel()
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.signInBackground
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 30)
                hiddenNumberView
                    .opacity(viewModel.shouldShowNumber ? 1.0 : 0.0)
                
                Spacer()
                headerView
                
                Spacer()
                    .frame(height: 10)
                
                textFieldView
                Text(viewModel.messageToShow)
                
                Spacer()

                endGameButtonView
                
                Spacer()
            }
        }
    }
    
    // MARK: - UI Elements
    
    private var hiddenNumberView: some View {
        Text(" The number was \n\(viewModel.numberToGuess.value)")
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .bold()
            .foregroundColor(.blue)
    }
    
    private var headerView: some View {
        Text(Constants.gameTitle)
            .font(.title)
            .bold()
    }
    
    private var textFieldView: some View {
        TextField(
            Constants.textFieldPlaceholder,
            text: $viewModel.textFieldText
        )
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .keyboardType(.numberPad)
        .foregroundColor(.black)
        .padding()
    }
    
    private var endGameButtonView: some View {
        Button {
            viewModel.endGame()
        } label: {
            Text("End the game")
                .font(.system(size: 24))
                .bold()
                .italic()
                .foregroundColor(.pink)
        }
    }
}

#Preview {
    GuessTheNumberView()
}
