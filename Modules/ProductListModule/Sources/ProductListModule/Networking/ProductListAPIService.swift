//  ProductListAPIService.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation
import NetworkingModule

protocol ProductListAPIProtocol: APIClient {
    func fetchProducts(limit: Int, skip: Int) async throws -> ProductsResponse
}

final class ProductListAPIService: ProductListAPIProtocol {
    public func fetchProducts(limit: Int, skip: Int) async throws -> ProductsResponse {
        if ProcessInfo.processInfo.arguments.contains("isRunningUITests") {
            return ProductsResponse(products: [ProductListModuleMockHelper.getProduct(stockLimit: 4)], total: 1, skip: 1, limit: 1)
        }
        
        let params = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "skip", value: "\(skip)"),
        ]
        return try await makeRequest(pathURL: "/products", responseType: ProductsResponse.self, queryParameters: params)
    }
}

