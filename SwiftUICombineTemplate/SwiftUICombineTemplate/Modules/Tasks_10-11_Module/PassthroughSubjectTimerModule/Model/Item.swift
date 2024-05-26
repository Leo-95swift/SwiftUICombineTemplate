//
//  Item.swift
//  SwiftUICombineTemplate
//
//  Created by Levon Shaxbazyan on 26.05.24.
//

import Foundation

/// Описаные продукта для продажы
struct Item: Identifiable {
    // уникальный id продукта
    var id = UUID()
    // фотография продукта
    var imageName: String?
    // имя продукта
    var name: String
    // цена продукта
    var price: Int
}
