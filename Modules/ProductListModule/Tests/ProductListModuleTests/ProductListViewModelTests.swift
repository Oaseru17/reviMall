//  ProductListViewModelTests.swift
//  Created by Precious Osaro on 16/04/2023.

import XCTest
@testable import ProductListModule

final class ProductListViewModelTests: XCTestCase {

    var sut: ProductListViewModel!
    var mockService: MockAPIService!
    
    @MainActor
    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
        sut = ProductListViewModel(apiClient: mockService)
    }

    override func tearDown() {
        super.tearDown()
        mockService = nil
        sut = nil
    }
    
    @MainActor
    func testFetchProduct_thenAPIServiceFetchProductIsCalled() async {
        await sut.fetchProducts()
        
        XCTAssertEqual(mockService.fetchProductCallCount, 1)
        XCTAssertFalse(sut.hasError)
        XCTAssertFalse(sut.isLoading)
    }
    
    @MainActor
    func testMultiFetchProduct_thenAPIServiceFetchMoreIsCalled() async {
        await sut.fetchProducts()
        
        XCTAssertEqual(mockService.fetchProductCallCount, 1)
        XCTAssertFalse(sut.hasError)
        XCTAssertFalse(sut.isLoading)
        
        mockService.canLoadMore = false
        await sut.fetchProducts()
        
        XCTAssertEqual(mockService.fetchProductCallCount, 2)
        XCTAssertFalse(sut.hasError)
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.loadingMore)
    }
}
