//
//  EpisodeView.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 26.05.24.
//

import SwiftUI

struct EpisodeView: View {
    
    // MARK: - Constants
    
    enum Constants {
        static let playIcon = "playIcon"
        static let isFavoriteButtonImage = "heart"
    }
    
    // MARK: - BindingObjects

    @EnvironmentObject var viewModel: URLSessionDataTaskPublisherViewModel
    @Binding var episodes: [Episode]
    
    // MARK: - Body

    var body: some View {
        LazyVStack(spacing: 55) {
            ForEach(episodes, id: \.name) { episode in
                VStack(alignment: .leading) {
                    if let index = episodes
                        .firstIndex(where: { $0.name == episode.name }) {
                        if index < viewModel.characterImages.count && 
                            index < viewModel.characterNames.count {
                            viewModel.characterImages[index]
                                .resizable()
                                .frame(width: 311, height: 232)
                            Spacer()
                            Text(viewModel.characterNames[index])
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                        }
                    }
                    Spacer()
                    HStack {
                        Image(Constants.playIcon)
                        Text("\(episode.name) | ")
                        +
                        Text(episode.episode)
                        Spacer()
                        Image(Constants.isFavoriteButtonImage)
                    }
                    .padding(.horizontal)
                    .frame(width: 311, height: 71)
                    .background(Color.gray.opacity(0.2))
                }
                .frame(width: 311, height: 357)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 2.5, x: 0, y: 3)
                )
                
            }
            
        }
        
    }
}
