//  Product.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation
import CoreModule

struct Product: Codable, Identifiable, ProductProtocol {
    
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
