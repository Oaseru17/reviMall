//  MockProductListViewModel.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation

public class MockProductListViewModel: ProductListViewModel {
    
    var fetchCount = 0
    var mockDefaultProductFetchCount = 30
    
    override func fetchProducts() async {
        isLoading = false
        fetchCount += 1
        let products = Array(repeating:ProductListModuleMockHelper.getProduct(), count: mockDefaultProductFetchCount)
        dataSource.productList.append(contentsOf: products)
    }
    
    override func fetchMoreIfAvailable(currentProduct: Product) async {
        guard fetchCount < 2 else { return }
        await fetchProducts()
    }
}
