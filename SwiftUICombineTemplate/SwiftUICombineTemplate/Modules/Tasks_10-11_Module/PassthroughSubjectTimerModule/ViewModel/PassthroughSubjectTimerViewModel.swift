//
//  PassthroughSubjectTimerViewModel.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 25.05.24.
//

import SwiftUI
import Combine

class PassthroughSubjectTimerViewModel: ObservableObject {
    
    // MARK: - Constants

    let verifyState = PassthroughSubject<String, Never>()
    
    // MARK: - Published Properties

    @Published var state: ViewState<[Item]> = .initial
    @Published var loadingPhase: LoadingPhase = .serverConnecting
    @Published var opacityValue: Double = 1.0
    @Published var timeValue = ""
    
    // MARK: - Public Properties
    
    var cancellables: Set<AnyCancellable> = []
    var timer: AnyCancellable?
    var animationTimer: AnyCancellable?
    var fetchedItems: [Item] = [
        .init(imageName: "pencil", name: "Pencil", price: 20),
        .init(imageName: "eraser", name: "Eraser", price: 15),
        .init(imageName: "ruler", name: "Ruler", price: 17),
        .init(imageName: "backpack", name: "Backpack", price: 120),
        .init(imageName: "soccerball", name: "Soccer ball", price: 35),
        .init(imageName: "basketball", name: "Basket ball", price: 32),
        .init(imageName: nil, name: "Raiser", price: 102),
        .init(imageName: "rosette", name: "Rosette", price: 27),
        .init(imageName: "camera", name: "Camera", price: 210),
        .init(imageName: "flashlight.off.fill", name: "Flashlight", price: 45),
        .init(imageName: "scissors", name: "scissors", price: 22)
    ]
    
    // MARK: - Private Properties

    private var elapsedSeconds = 0
    
    // MARK: - Initializers
    
    init() {
        bind()
    }
    
    // MARK: - Public Methods
    
    func start() {
        elapsedSeconds = 0
        startTimer()
        state = .loading
        loadingPhase = .serverConnecting
        simulateLoading()
        startAnimation()
    }
    
    func bind() {
        verifyState
            .sink(receiveValue: { [unowned self] value in
                if !value.isEmpty {
                    timeValue = value
                }
            })
            .store(in: &cancellables)
        
    }
    
    func startTimer() {
        verifyState.send("00:00")
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [unowned self] date in
                elapsedSeconds += 1
                let minutes = elapsedSeconds / 60
                let seconds = elapsedSeconds % 60
                let timeString = String(format: "%02d:%02d", minutes, seconds)
                verifyState.send(timeString)
            })
    }
    
    // MARK: - Private Methods

    private func simulateLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loadingPhase = .loadingGoods
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.showItems()
            }
        }
    }
    
    private func startAnimation() {
        animationTimer = Timer
            .publish(every: 0.8, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.opacityValue = self.opacityValue == 1.0 ? 0.0 : 1.0
            }
    }
    
    private func showItems() {
        _ = Just(fetchedItems)
            .map { items in
                items.filter { $0.price >= 10 && $0.imageName != nil }
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.state = .error(error)
                }
            }, receiveValue: { [unowned self] items in
                self.timer?.cancel()
                self.state = .data(items)
            })
    }
    
}
