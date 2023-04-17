//  ProductDetailsViewModelTests.swift
//  Created by Precious Osaro on 16/04/2023.

import XCTest
import CartModule
@testable import ProductListModule

final class ProductDetailsViewModelTests: XCTestCase {
    
    private let stockLimit = 2
    
    var sut: ProductDetailsViewModel!
    var cartService: MockCartService!
    var repository: CartRepository!
    
    @MainActor
    override func setUp() {
        super.setUp()
        repository = CartRepository()
        cartService = MockCartService(repository: repository)
        sut = ProductDetailsViewModel(model: ProductListModuleMockHelper.getProduct(stockLimit: stockLimit), cartService: cartService)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        cartService = nil
        repository = nil
    }
    
    @MainActor
    func testReduceItemCount() {
        XCTAssertEqual(sut.itemCount, 1)
        sut.reduceItemInCart()
        
        XCTAssertEqual(sut.itemCount, 0)
        sut.reduceItemInCart()
        
        XCTAssertEqual(sut.itemCount, 0)
    }
    
    @MainActor
    func testIncreaseItemCount() {
        XCTAssertEqual(sut.itemCount, 1)
        sut.increaseItemInCart()
        
        XCTAssertEqual(sut.itemCount, 2)
        sut.increaseItemInCart()
    }
    
    @MainActor
    func testIncreaseItemCount_whenStockLimitReached() {
        XCTAssertEqual(sut.itemCount, 1)
        sut.increaseItemInCart()
        
        XCTAssertEqual(sut.itemCount, 2)
        sut.increaseItemInCart()
        
        XCTAssertEqual(sut.itemCount, 2)
        sut.increaseItemInCart()
        
        XCTAssertEqual(sut.itemCount, 2)
    }
    
    @MainActor
    func testAddProduct_whenQuantityExceedsStock_thenCartServiceIsNotCalled() {
        
        sut.addProduct(quantity: 10)
        
        XCTAssertEqual(cartService.addProductCalled, 0)
        XCTAssertEqual(cartService.totalItemsCount, 0)
        XCTAssertTrue(sut.showQuantityReach)
    }
    
    @MainActor
    func testAddProduct_whenQuantityIsWithinStock_thenProductIsAdded() {
        
        sut.addProduct(quantity: 1)
        
        XCTAssertEqual(cartService.addProductCalled, 1)
        XCTAssertEqual(cartService.totalItemsCount, 1)
        XCTAssertFalse(sut.showQuantityReach)
    }
}
