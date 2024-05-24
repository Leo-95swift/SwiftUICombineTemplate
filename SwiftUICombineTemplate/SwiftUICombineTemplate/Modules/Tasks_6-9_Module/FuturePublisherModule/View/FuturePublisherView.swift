//
//  FuturePublisherView.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 23.05.24.
//

import SwiftUI
import Combine

struct FuturePublisherView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let textFieldPlaceholder = "Введите число"
        static let checkButtonText = "Проверить простоту числа"
    }
    
    // MARK: - StateObjects

    @StateObject var viewModel = FuturePublisherViewModel()
    
    // MARK: - Body

    var body: some View {
        VStack {
            Spacer()
            textFieldView
            
            checkButtonView
            Spacer()
                .frame(height: 20)
            
            Text(viewModel.textToShow)
                .foregroundColor(.green)
            Spacer()
        }
    }
    
    // MARK: - UI Elements

    private var textFieldView: some View {
        TextField(
            Constants.textFieldPlaceholder,
            text: $viewModel.textFieldText
        )
            .textFieldStyle(.roundedBorder)
            .padding()
    }
    
    private var checkButtonView: some View {
        Button(Constants.checkButtonText) {
            viewModel.check()
        }
    }
}

#Preview {
    FuturePublisherView()
}
