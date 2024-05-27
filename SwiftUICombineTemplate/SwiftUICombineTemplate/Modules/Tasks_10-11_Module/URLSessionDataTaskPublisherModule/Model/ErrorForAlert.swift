//
//  ErrorForAlert.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 26.05.24.
//

import Foundation

/// Описание для показа ошибки на алерте
struct ErrorForAlert: Error, Identifiable {
    // уникальный id ошибки
    var id = UUID()
    // заголовок ошибки
    let title = "Error"
    // сообение в ошибке
    let message: String
}
