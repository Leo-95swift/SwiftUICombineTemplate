//
//  ViewState.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 26.05.24.
//

import Foundation

public enum ViewState<Model> {
    case initial
    case loading
    case data(_ data: Model)
    case error(_ error: Error)
}

public enum LoadingPhase {
    case serverConnecting
    case loadingGoods
}
