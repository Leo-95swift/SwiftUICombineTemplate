//
//  MultiplePipelineView.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 22.05.24.
//

import SwiftUI
import Combine

struct MultiplePipelineView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let productTitle = "Товар"
        static let productPriceTitle = "Цена"
        static let fontName = "Verdana-bold"
        static let resetBasketText = "Очистить корзину"
    }
        
    // MARK: - Body

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            
            allProductsListView
            
            Spacer()
                .frame(height: 100)
            
            VStack(spacing: 10) {
                headerView
                choosenProductsListView
                
                Spacer()
                    .frame(height: 10)
                
                Text("Итоговая сумма: \(String(viewModel.totalSum))")
            }
            Spacer()
            
            resetButtonView
        }
        .padding()
    }
    
    // MARK: - Private properties
    
    @StateObject private var viewModel = MultiplePipelineViewModel()
    
    // MARK: - UI Elements

    private var allProductsListView: some View {
        ForEach(viewModel.products.indices, id: \.self) { index in
            HStack() {
                Text(viewModel.products[index].name)
                Stepper("") {
                    if viewModel.addedProducts.allSatisfy({ $0.id != viewModel.products[index].id }) {
                        viewModel.addedProducts.append(viewModel.products[index])
                    }
                } onDecrement: {
                    if let position = viewModel.addedProducts.firstIndex(where: { $0.id == viewModel.products[index].id }) {
                        viewModel.addedProducts.remove(at: position)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var headerView: some View {
        HStack {
            Text(Constants.productTitle)
            Spacer()
            Text(Constants.productPriceTitle)
        }
        .padding(.horizontal)
        .font(.custom(Constants.fontName, size: 20))
    }
    
    private var choosenProductsListView: some View {
        ForEach(viewModel.check, id: \.id) { product in
            HStack {
                Text(product.name)
                Spacer()
                Text(String(product.price))
            }
            .padding(.horizontal)
        }
    }
    
    private var resetButtonView: some View {
        Button {
            viewModel.clearBasket()
        } label: {
            Text(Constants.resetBasketText)
        }
    }
}

#Preview {
    MultiplePipelineView()
}
