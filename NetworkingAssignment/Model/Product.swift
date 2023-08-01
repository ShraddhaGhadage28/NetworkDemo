//
//  Product.swift
//  NetworkingAssignment
//
//  Created by Shraddha Ghadage on 28/07/2023.
//

import Foundation
struct ProductResponse: Codable {
    let status: Int
    let data: [Product]
}

struct Product: Codable {
    let name: String
    let producer: String
    let cost: Int
    let productImages: String

    enum CodingKeys: String, CodingKey {
        case name
        case producer
        case cost
        case productImages = "product_images"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.producer = try container.decode(String.self, forKey: .producer)
        self.cost = try container.decode(Int.self, forKey: .cost)
        self.productImages = try container.decode(String.self, forKey: .productImages)
    }
}
