//  CartDetailViewModel.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation
import CoreModule

class CartDetailViewModel: ObservableObject {
    
    @Published var checkOutAlert = false
    @Published var showQuantityReach = false
    @Published private var cartService: CartService
    
    var items: [CartItem] {
        cartService.getCartItems()
    }
    
    var showEmptyCart: Bool {
        items.isEmpty
    }
    
    var cartTotal: String {
        cartService.cartTotal
    }
    
    public init(cartService: CartService = CartService.shared) {
        self.cartService = cartService
    }
    
    func checkOut() {
        cartService.checkOut()
    }
    
    func removeItem(_ item: CartItem) {
        cartService.removeItem(item)
    }
    
    func decreaseItemQuantity(_ item: CartItem) {
        decreaseItemQuantity(item)
    }
    
    func increaseItemQuantity(_ item: CartItem) {
        increaseItemQuantity(item)
    }
}
