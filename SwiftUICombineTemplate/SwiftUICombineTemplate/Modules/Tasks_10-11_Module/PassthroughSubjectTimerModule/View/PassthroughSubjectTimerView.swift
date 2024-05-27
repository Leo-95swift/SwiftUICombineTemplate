//
//  PassthroughSubjectTimerView.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 25.05.24.
//

import SwiftUI
import Combine

struct PassthroughSubjectTimerView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let serverConnectText = "Connecting to server..."
        static let loadingGoodsText = "Loading goods..."
        static let startButtonText = "Start"
        
    }
    
    // MARK: - StateObjects

    @StateObject var viewModel = PassthroughSubjectTimerViewModel()
    
    // MARK: - Body

    var body: some View {
        VStack {
            Text("Time left \(viewModel.timeValue)")
                .frame(height: 50)
            Spacer()
            
            Form {
                switch viewModel.state {
                case .initial:
                    EmptyView()
                case .loading:
                    loadingView
                case .data(let items):
                    Section(header: Text("")) {
                        List(items, id: \.id) { item in
                            HStack {
                                Image(systemName: item.imageName ?? "")
                                    .frame(width: 20, height: 20)
                                Spacer()
                                    .frame(width: 20)
                                Text(item.name)
                                    .frame(width: 140, alignment: .leading)
                                Text("\(String(item.price))$")
                            }
                        }
                    }
                case .error(let error):
                    Text(error.localizedDescription)
                }
            }
            startButtonView
        }
    }
    
    // MARK: - UI Elements
    
    private var loadingView: some View {
        VStack {
            switch viewModel.loadingPhase {
            case .serverConnecting:
                serverConnectingView
            case .loadingGoods:
                loadingGoodView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var serverConnectingView: some View {
        VStack {
            Text(Constants.serverConnectText)
                .font(.title2)
                .fontWeight(.semibold)
                .opacity(viewModel.opacityValue)
                .animation(.easeIn(duration: 1), value: viewModel.opacityValue)
            ProgressView()
        }
    }
    
    private var loadingGoodView: some View {
        VStack {
            Text(Constants.loadingGoodsText)
                .font(.title2)
                .fontWeight(.semibold)
                .opacity(viewModel.opacityValue)
                .animation(.easeIn(duration: 1), value: viewModel.opacityValue)
            ProgressView()
        }
    }
    
    private var startButtonView: some View {
        Button(Constants.startButtonText) {
            viewModel.start()
        }
        .frame(height: 50)
    }
}

#Preview {
    PassthroughSubjectTimerView()
}

