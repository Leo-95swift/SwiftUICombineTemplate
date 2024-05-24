//
//  EmptyPublisherView.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 24.05.24.
//

import SwiftUI
import Combine

struct EmptyPublisherView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let textFieldPlaceholder = "Введите строку"
        static let addButtonTitle =  "Добавить"
        static let resetButtonTitle =  "Очистить список"
    }
    
    // MARK: - StateObjects

    @StateObject private var viewModel = EmptyPublisherViewModel()
    
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
            viewModel.valueToAdd.value = viewModel.textFieldInput.value
        }
        .disabled(!viewModel.isActive)
    }
    
    private var resetButtonView: some View {
        Button(Constants.resetButtonTitle) {
            viewModel.clearList()
        }
    }
    
    private var listView: some View {
        List(viewModel.dataToView.value, id: \.self) { item in
            Text(item)
        }
        .font(.title)
    }
}
