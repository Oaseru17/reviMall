//  CartItem.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation
import CoreModule

public struct CartItem: Identifiable, Hashable {
    
    public let id = UUID()
    let product: ProductProtocol
    
    public var quantity: Int
    
    var total: Double {
        Double(quantity) * product.finalPrice
    }
    
    var formattedTotal: String {
        total.formatted(.currency(code: "USD"))
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(product.id)
        hasher.combine(product.title)
        hasher.combine(product.description)
    }
    
    public static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        lhs.product.id == rhs.product.id
    }
}
