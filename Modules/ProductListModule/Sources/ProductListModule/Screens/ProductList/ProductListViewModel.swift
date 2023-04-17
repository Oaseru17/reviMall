//  ProductListViewModel.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation
import SwiftUI
import NetworkingModule
import CartModule

struct ProductsRepository {
    var productList: [Product] = []
}

@MainActor
public class ProductListViewModel: ObservableObject {
    private let apiClient: ProductListAPIProtocol
    private let defaultProductFetchCount = 30
    
    var hasError = false
    private(set) var loadingMore = false
    private(set) var errorMessage: String = "Unknown error"
    private var skip = 0
    private var canFetchMore = true
    private var lastProductId = 0
    
    @Published var isLoading = true
    @Published var dataSource = ProductsRepository()
    @Published private var cartService: CartService
    
    var cartItemCount: Int {
        cartService.totalItemsCount
    }
    
    var productList: [Product] {
        dataSource.productList
    }
    
    init(apiClient: ProductListAPIProtocol = ProductListAPIService(), repository: ProductsRepository = ProductsRepository(), cartService: CartService = CartService.shared) {
        self.apiClient = apiClient
        self.dataSource = repository
        self.cartService = cartService
    }

    func fetchProducts() async {
        do {
            guard canFetchMore else {
                hideLoading()
                return
            }
            let products = try await apiClient.fetchProducts(limit: defaultProductFetchCount, skip: skip).products
            hideLoading()
            guard products.count > 0  else {
                canFetchMore = false
                return
            }
            lastProductId = products.last?.id ?? 0
            skip += products.count
            dataSource.productList.append(contentsOf: products)
            
            canFetchMore = (products.count >= defaultProductFetchCount)
        } catch {
            canFetchMore = false
            hasError = true
            hideLoading()
            errorMessage = error.localizedDescription
        }
    }
    
    func fetchMoreIfAvailable(currentProduct: Product) async {
        guard lastProductId == currentProduct.id, canFetchMore else { return }
        loadingMore = true
        await fetchProducts()
        loadingMore = false
    }
    
    private func hideLoading() {
        isLoading = false
    }
}
