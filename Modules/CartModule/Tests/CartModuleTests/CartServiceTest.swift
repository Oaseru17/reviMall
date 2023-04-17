// CartServiceTest.swift
//  Created by Precious Osaro on 16/04/2023.

import XCTest
@testable import CartModule

final class CartServiceTest: XCTestCase {
    
    var sut: CartService!
    var repository: CartRepository!
    
    override func setUp() {
        super.setUp()
        repository = CartRepository()
        sut = CartService(repository: repository)
    }
    
    override func tearDown() {
        super.tearDown()
        repository = nil
        sut = nil
    }
    
    func testCanShowCartAndTotalItems() {
        XCTAssertFalse(sut.canShowCart)
        XCTAssertEqual(sut.totalItemsCount, 0)
        
        let product = MockProduct()
        sut.addProduct(product: product, quantity: 2)
        
        let product2 = MockProduct()
        sut.addProduct(product: product2, quantity: 7)
        
        XCTAssertTrue(sut.canShowCart)
        XCTAssertEqual(sut.totalItemsCount, 9)
    }
    
    func testCartTotal() {
        XCTAssertFalse(sut.canShowCart)
        XCTAssertEqual(sut.totalItemsCount, 0)
        XCTAssertEqual(sut.cartTotal, "$0.00")
        
        let product = MockProduct()
        product.discountPercentage = 10
        product.price = 100
        sut.addProduct(product: product, quantity: 2)
        
        let product2 = MockProduct()
        product2.discountPercentage = 90
        product2.price = 100
        sut.addProduct(product: product2, quantity: 7)
        
        XCTAssertTrue(sut.canShowCart)
        XCTAssertEqual(sut.totalItemsCount, 9)
        XCTAssertEqual(sut.cartTotal, "$250.00")
    }
}
