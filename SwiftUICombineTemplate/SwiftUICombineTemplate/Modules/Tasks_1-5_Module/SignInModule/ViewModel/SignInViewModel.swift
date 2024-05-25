//
//  SignInViewModel.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 21.05.24.
//

import SwiftUI

/// Для бизнес логики экрана регистрации
final class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var emailValidation = ""
    @Published var passwordValidation = ""

    var isSignInButtonEnabled: Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    init() {
        $email
            .map { $0.isEmpty ? "❌" : "✅" }
            .assign(to: &$emailValidation)
        
        $password
            .map { $0.isEmpty ? "❌" : "✅" }
            .assign(to: &$passwordValidation)
    }
}

