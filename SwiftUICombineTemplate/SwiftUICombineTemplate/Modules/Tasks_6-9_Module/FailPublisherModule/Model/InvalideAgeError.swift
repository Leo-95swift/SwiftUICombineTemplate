//
//  InvalideAgeError.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 23.05.24.
//

import Foundation

public enum InvalidInput: String, Error, Identifiable {
    public var id: String { rawValue }
    
    case nonNumeric = "Введенное значение не является\nчислом"
}
