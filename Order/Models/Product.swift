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
    var rating: RatingValue?
    
    init(title: String, imageName: String? = nil, captionText: String? = nil, rating: RatingValue? = nil) {
        self.title = title
        self.imageName = imageName
        self.captionText = captionText
        self.rating = rating
    }
}

let testProducts: [Product] = [
    Product(title: "Золотое плоское обручальное кольцо 4 мм", imageName: "goldRing1", captionText: "Размер 17"),
    Product(title: "Золотое плоское обручальное кольцо 4 мм", imageName: "goldRing2"),
    Product(title: "Золотое плоское обручальное кольцо 4 мм", imageName: "silverRing"),
    Product(title: "Золотое плоское обручальное кольцо 4 мм", imageName: "goldRing3")
]
