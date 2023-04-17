//  CartItemTest.swift
//  Created by Precious Osaro on 16/04/2023.

import XCTest
@testable import CartModule

final class CartRepositoryTest: XCTestCase {

    var sut: CartRepository!
     
    override func setUp() {
        super.setUp()
        sut = CartRepository()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testAddItem_whenQuantityIsZero_thenNoItemIsAdded() {
        let result = sut.addItem(product: MockProduct(), quantity: 0)
        XCTAssertFalse(result)
        XCTAssertEqual(sut.items.count, 0)
    }
    
    func testAddItem_whenQuantityIsMoreThanZero_thenItemIsAdded() throws {
        let product = MockProduct()
        let result = sut.addItem(product: product, quantity: 2)
        XCTAssertTrue(result)
        XCTAssertEqual(sut.items.count, 1)
        
        let returnedCartItem = try XCTUnwrap(sut.getItem(product: product))
        XCTAssertEqual(product.id, returnedCartItem.product.id)
        XCTAssertEqual(returnedCartItem.quantity, 2)
    }
    
    func testAddItem_whenQuantityIsMoreThanStock_thenItemIsNotAdded() throws {
        let product = MockProduct()
        let result = sut.addItem(product: product, quantity: 2)
        XCTAssertTrue(result)
        XCTAssertEqual(sut.items.count, 1)
        
        let returnedCartItem = try XCTUnwrap(sut.getItem(product: product))
        XCTAssertEqual(product.id, returnedCartItem.product.id)
        XCTAssertEqual(returnedCartItem.quantity, 2)
        
        let resultWhenExcess = sut.addItem(product: product, quantity: 10)
        XCTAssertFalse(resultWhenExcess)
        XCTAssertEqual(sut.items.count, 1)
        
        let returnedCartItemAfterExcess = try XCTUnwrap(sut.getItem(product: product))
        XCTAssertEqual(product.id, returnedCartItemAfterExcess.product.id)
        XCTAssertEqual(returnedCartItemAfterExcess.quantity, 2)
    }
    
    func testAddItem_whenDifferentProductExist_thenItemIsAdded() throws {
        let product = MockProduct()
        let result = sut.addItem(product: product, quantity: 2)
        XCTAssertTrue(result)
        XCTAssertEqual(sut.items.count, 1)
        
        let returnedCartItem = try XCTUnwrap(sut.getItem(product: product))
        XCTAssertEqual(product.id, returnedCartItem.product.id)
        XCTAssertEqual(returnedCartItem.quantity, 2)
        
        let product2 = MockProduct()
        let result2 = sut.addItem(product: product2, quantity: 4)
        XCTAssertTrue(result2)
        XCTAssertEqual(sut.items.count, 2)
        
        let returnedCartItem2 = try XCTUnwrap(sut.getItem(product: product2))
        XCTAssertEqual(product2.id, returnedCartItem2.product.id)
        XCTAssertEqual(returnedCartItem2.quantity, 4)
    }
    
    func testRemoveItem() throws {
        let product = MockProduct()
        let result = sut.addItem(product: product, quantity: 2)
        XCTAssertTrue(result)
        XCTAssertEqual(sut.items.count, 1)
        
        let  returnedCartItem = try XCTUnwrap(sut.getItem(product: product))
        sut.removeItem(id: returnedCartItem.id)
        XCTAssertEqual(sut.items.count, 0)
    }
    
    func testClearAll() throws {
        let product = MockProduct()
        let result = sut.addItem(product: product, quantity: 2)
        XCTAssertTrue(result)
        XCTAssertEqual(sut.items.count, 1)
        
        sut.clearAll()
        XCTAssertEqual(sut.items.count, 0)
    }
}
