//  CartService.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation
import SwiftUI
import CoreModule

public class CartService: ObservableObject {
    
    public static let shared = CartService(repository: CartRepository())
    
    @Published public var repository: CartRepository
    
    public var canShowCart: Bool {
        totalItemsCount > 0
    }
    
    public var totalItemsCount: Int {
        repository.items.map({$0.quantity}).reduce(0, +)
    }
    
    public var cartTotal: String {
        repository.items.map({ $0.total}).reduce(0, +).formatted(.currency(code: "USD"))
    }
 
    public init(repository: CartRepository) {
        self.repository = repository
    }
    
    public func getItemFromCart(product: ProductProtocol) -> CartItem? {
        repository.getItem(product: product)
    }
    
    public func getCartItems() -> [CartItem] {
        repository.items
    }
    
    public func addProduct(product: ProductProtocol, quantity: Int) {
        repository.addItem(product: product, quantity: quantity)
    }
    
    public func getCartItemsCount() -> Int {
        getCartItems().count
    }
    
    func removeItem(_ item: CartItem) {
        repository.removeItem(id: item.id)
    }
    
    @discardableResult
    func increaseItemQuantity(_ item: CartItem) -> Bool {
        repository.addItem(product: item.product, quantity: 1)
    }
    
    func decreaseItemQuantity(_ item: CartItem) {
        guard item.quantity > 1 else { return }
        repository.addItem(product: item.product, quantity: -1)
    }
    
    func checkOut() {
        repository.clearAll()
    }
}
