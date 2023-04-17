//  CartRepository.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation
import SwiftUI
import CoreModule

public struct CartRepository {
    
    public var items: [CartItem] = []
    
    public init() {}
    
    @discardableResult
    mutating func addItem(product: ProductProtocol, quantity: Int) -> Bool {
        if let cartIndex = items.firstIndex(where: { $0.product.id == product.id }) {
            let cartQuantity = items[cartIndex].quantity
            guard product.stock - (cartQuantity + quantity) >= 0 else { return false }
            items[cartIndex].quantity += quantity
            if items[cartIndex].quantity <= 0 {
                items.remove(at: cartIndex)
            }
        } else {
            if quantity <= 0 {
                return false
            }
            items.append(CartItem(product: product, quantity: quantity))
        }
        return true
    }
    
    func getItem(product: ProductProtocol) -> CartItem? {
        items.first { $0.product.id == product.id }
    }
    
    mutating func removeItem(id: UUID) {
        items.removeAll { $0.id == id }
    }
    
    mutating func clearAll() {
        items.removeAll()
    }
}
