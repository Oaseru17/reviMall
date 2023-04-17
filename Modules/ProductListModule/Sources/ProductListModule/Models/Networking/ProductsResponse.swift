//  ProductsResponse.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation

public struct ProductsResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
