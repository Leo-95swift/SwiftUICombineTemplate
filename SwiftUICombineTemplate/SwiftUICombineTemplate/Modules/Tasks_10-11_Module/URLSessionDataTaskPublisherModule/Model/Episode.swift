//
//  Episode.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 26.05.24.
//

/// Описание для массива эпизодa
struct Episode: Codable {
    // Название эпизода
    let name: String
    // Код эпизода
    let episode: String
    // Персонажи эпизода
    let characters: [String]
}
