//   MockCartServic.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation
import CoreModule

public class MockCartService: CartService {
    
    public var addProductCalled = 0
    
    override public func addProduct(product: ProductProtocol, quantity: Int) {
        addProductCalled += 1
        super.addProduct(product: product, quantity: quantity)
    }
}

public class MockProduct: ProductProtocol {
    
    public var id: Int = UUID().hashValue
    public var title: String = "Test"
    public var description: String = "Test"
    public var price: Int = 100
    public var rating: Double = 4.3
    public var discountPercentage: Double = 2.5
    public var stock: Int = 10
    public var brand: String = "TestBrand"
    public var category: String = "TestCategory"
    public var thumbnail: String = "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
    public var images: [String] = ["https://i.dummyjson.com/data/products/1/thumbnail.jpg",
                                   "https://i.dummyjson.com/data/products/1/thumbnail.jpg"]
}
