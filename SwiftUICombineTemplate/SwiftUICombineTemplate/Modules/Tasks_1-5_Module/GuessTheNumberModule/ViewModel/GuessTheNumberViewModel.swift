//
//  GuessTheNumberViewModel.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 22.05.24.
//

import SwiftUI
import Combine

final class GuessTheNumberViewModel: ObservableObject {
    
    // MARK: - Constats
    
    enum Constants {
        static let lessThen = "Введенное число меньше загаданного"
        static let moreThen = "Введенное число больше загаданного"
        static let equal = "Вы угадали!"
    }
    
    @Published var textFieldText = ""
    @Published var shouldShowNumber = false
    @Published var messageToShow = ""
    
    var numberToGuess = CurrentValueSubject<Int, Never>(Int.random(in: 0...100))
    var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Initializers
    
    init() {
        
        $textFieldText
            .dropFirst(2)
            .map { text -> Int in
                guard let guessedNumber = Int(text) else { return 0 }
                return guessedNumber
            }
            .delay(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [unowned self] guessedNumber in
                self.compareNumbers(guessedNumber)

            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public Methodes
    
    func compareNumbers(_ guessedNumber: Int) {
        let actualNumber = numberToGuess.value
        if guessedNumber < actualNumber {
            messageToShow = Constants.lessThen
        } else if guessedNumber > actualNumber {
            messageToShow = Constants.moreThen
        } else {
            messageToShow = Constants.equal
        }
    }
    
    func endGame() {
        cancellables.removeAll()
        shouldShowNumber = true
    }
    
}
