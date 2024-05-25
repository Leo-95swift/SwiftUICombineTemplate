//
//  JustSequenceView.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 24.05.24.
//

import SwiftUI
import Combine

struct JustSequenceView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let addFruitButtonTitle = "Добавить фрукт"
        static let removeFruitButtonTitle = "Удалить фрукт"
    }
    
    // MARK: - StateObjects

    @StateObject var viewModel = TaskViewModel()
    
    // MARK: - Body

    var body: some View {
        VStack {
            Form {
                Section(header: Text("")) {
                    List(viewModel.dataToView, id: \.self) { item in
                        Text(item)
                    }
                }
            }
            HStack(spacing: 60) {
                Button(Constants.addFruitButtonTitle) {
                    viewModel.addFruit()
                }
                Button(Constants.removeFruitButtonTitle) {
                    viewModel.removeFruit()
                }
            }
            .frame(height: 50)
        }
    }
    
}

#Preview {
    JustSequenceView()
}
