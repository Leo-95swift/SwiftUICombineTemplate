//
//  ViewState.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 27.05.24.
//


public enum EpisodeViewState<Model> {
    case loading
    case data(_ data: Model)
    case error(_ error: Error)
}
