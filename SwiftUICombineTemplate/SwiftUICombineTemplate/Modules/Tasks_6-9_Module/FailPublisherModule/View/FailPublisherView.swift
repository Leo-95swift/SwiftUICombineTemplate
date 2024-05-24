//
//  FailPublisherView.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 23.05.24.
//

import SwiftUI
import Combine

struct FailPublisherView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let textFieldPlaceholder = "Введите число"
        static let addButtonTitle =  "Добавить"
        static let resetButtonTitle =  "Очистить список"
    }
    
    // MARK: - StateObjects

    @StateObject private var viewModel = FailPublisherViewModel()
    
    // MARK: - Body

    var body: some View {
            VStack {
                Spacer()
                VStack {
                    textFieldView
                    HStack(spacing: 50) {
                        addButtonView
                        resetButtonView
                    }
                    .padding()
                    Text(viewModel.error?.rawValue ?? "")
                        .foregroundColor(.red)
                }
                listView
                
            }
        }
    
    // MARK: - UI Elements

    private var textFieldView: some View {
        TextField(
            Constants.textFieldPlaceholder,
            text: $viewModel.textFieldInput.value
        )
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
    }
    
    private var addButtonView: some View {
        Button(Constants.addButtonTitle) {
            viewModel.addToList()
        }
    }
    
    private var resetButtonView: some View {
        Button(Constants.resetButtonTitle) {
            viewModel.clearList()
        }
    }
    
    private var listView: some View {
        List(viewModel.dataToView, id: \.self) { item in
                Text(item)
        }
        .font(.title)
    }
}

#Preview {
    FailPublisherView()
}
