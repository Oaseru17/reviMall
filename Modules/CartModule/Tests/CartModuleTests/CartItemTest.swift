//  CartItemTest.swift
//  Created by Precious Osaro on 16/04/2023.

import XCTest
@testable import CartModule

final class CartItemTest: XCTestCase {
    func testCartItem() {
        let product = MockProduct()
        product.price = 100
        product.discountPercentage = 10
        let cartItem = CartItem(product: product, quantity: 4)
        
        let expectedTotal = 90 * 4.0
        
        XCTAssertEqual(cartItem.product.id, product.id)
        XCTAssertEqual(cartItem.product.title, product.title)
        XCTAssertEqual(cartItem.product.discountPercentage, product.discountPercentage)
        XCTAssertEqual(cartItem.product.description, product.description)
        
        XCTAssertEqual(cartItem.total, expectedTotal)
    }
}
