//
//  URLSessionDataTaskPublisherView.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 27.05.24.
//

import SwiftUI
import Combine

struct URLSessionDataTaskPublisherView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let titleText = "titleText"
        static let loadingImage = "portal"
        static let dissmissButonText = "Try again"
    }
    
    // MARK: - State Properties
    
    @StateObject private var viewModel = URLSessionDataTaskPublisherViewModel()
    @State private var isAnimating = false
    @State private var episodes: [Episode] = []

    // MARK: - Body
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                VStack {
                    Image(Constants.titleText)
                    Spacer()
                        .frame(height: 146)
                    Image(Constants.loadingImage)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(
                            Animation.linear(duration: 2)
                                .repeatForever(autoreverses: false),
                            value: isAnimating
                        )
                        .onAppear {
                            isAnimating = true
                        }
                    Spacer()
                }
            case .data(let fetchedEpisodes):
                ScrollView {
                    Image(Constants.titleText)
                        .padding(.bottom, 20)
                    EpisodeView(episodes: $episodes)
                }
                .onAppear {
                    episodes = fetchedEpisodes
                }
            case .error(_):
                EmptyView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                viewModel.fetchEpisodes()
            }
        }
        .alert(item: $viewModel.errorForAlert) { error in
            Alert(
                title: Text(error.title),
                message: Text(error.message),
                dismissButton: .default(
                    Text(Constants.dissmissButonText),
                    action: {
                viewModel.fetchEpisodes()
            }))
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    URLSessionDataTaskPublisherView()
}
