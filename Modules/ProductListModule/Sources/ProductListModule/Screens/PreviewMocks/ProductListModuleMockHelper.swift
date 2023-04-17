//  ProductListModuleMockHelper.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation

enum ProductListModuleMockHelper {
    
    static func getProduct(stockLimit: Int = 5) -> Product {
        Product(id: UUID().hashValue,
                title: "Handcraft",
                description: "An apple mobile which is nothing like apple",
                price: 456,
                discountPercentage: 4.2,
                rating: 4.1,
                stock: stockLimit,
                brand: "Apple",
                category: "smartphones",
                thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg",
                images: [
                    "https://i.dummyjson.com/data/products/1/1.jpg",
                    "https://i.dummyjson.com/data/products/1/2.jpg",
                    "https://i.dummyjson.com/data/products/1/3.jpg",
                    "https://i.dummyjson.com/data/products/1/4.jpg",
                    "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
                ])
    }
}
