//  ProductDetailsViewModel.swift
//  Created by Precious Osaro on 16/04/2023.

import SwiftUI
import CartModule
import CoreModule

@MainActor
class ProductDetailsViewModel: ObservableObject {
    
    @Published var state: Product
    @Published private(set) var itemCount: Int = 1
    @Published var showQuantityReach: Bool = false
    @Published private var cartService: CartService
    
    var canShowCartItemCount: Bool {
        itemCount > 1
    }
    
    var cartItemCount: Int {
        cartService.totalItemsCount
    }
    
    public init(model: Product, cartService: CartService = CartService.shared) {
        self.cartService = cartService
        self.state = model
    }
    
    func reduceItemInCart() {
        guard itemCount > 0 else { return }
        itemCount -= 1
    }
    
    func increaseItemInCart() {
        guard (state.stock - (itemCount + 1 + productQuantityInCart(product: state))) >= 0 else {
            showQuantityReach = true
            return
        }
        itemCount += 1
    }
    
    func productQuantityInCart(product: ProductProtocol) -> Int {
        cartService.getItemFromCart(product: product)?.quantity ?? 0
    }
    
    func addProduct(quantity: Int) {
        guard (state.stock - (quantity + productQuantityInCart(product: state))) >= 0 else {
            showQuantityReach = true
            return
        }
        cartService.addProduct(product: state, quantity: quantity)
    }
}
