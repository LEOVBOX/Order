//
//  Product.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 31.10.2024.
//

import Foundation

struct Product {
    let title: String
    let imageName: String?
    let captionText: String?
    
    init(title: String, imageName: String? = nil, captionText: String? = nil) {
        self.title = title
        self.imageName = imageName
        self.captionText = captionText
    }
}

let testProducts: [Product] = [
    Product(title: "Золотое плоское обручальное кольцо 4 мм", imageName: "goldRing1"),
    Product(title: "Золотое плоское обручальное кольцо 4 мм", imageName: "goldRing2"),
    Product(title: "Золотое плоское обручальное кольцо 4 мм", imageName: "silverRing"),
    Product(title: "Золотое плоское обручальное кольцо 4 мм", imageName: "goldRing3")
]
