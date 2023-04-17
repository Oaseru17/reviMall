//  MockAPIService.swift
//  Created by Precious Osaro on 16/04/2023.

import NetworkingModule

final class MockAPIService: ProductListAPIProtocol {
    
    var fetchProductCallCount = 0
    var canLoadMore = true
    
    public func fetchProducts(limit: Int, skip: Int) async throws -> ProductsResponse {
        fetchProductCallCount += 1
        var products: [Product] = []
        if skip <= 100 && canLoadMore {
            products = Array(repeating: ProductListModuleMockHelper.getProduct(), count: limit)
        }
        return ProductsResponse(products: products, total: 100, skip: skip, limit: limit)
    }
}
