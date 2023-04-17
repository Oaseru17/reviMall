//  ProductProtocol.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation

public protocol ProductProtocol {
    var id: Int { get }
    var title: String { get }
    var description: String { get }
    var price: Int { get }
    var rating: Double { get }
    var discountPercentage: Double { get }
    var stock: Int { get }
    var brand: String { get }
    var category: String { get }
    var thumbnail: String { get }
    var images: [String] { get }
    
    var finalPrice: Double { get }
    var formattedPrice: String { get }
}

public extension ProductProtocol {
    var finalPrice: Double {
        Double(price) * ((100 - discountPercentage) / 100)
    }
    var formattedPrice: String {
        finalPrice.formatted(.currency(code: "USD"))
    }
}
