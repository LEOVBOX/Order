//
//  Review.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 03.11.2024.
//

import Foundation

enum RatingValue: Int {
    case none = 0
    case awful = 1
    case bad = 2
    case norm = 3
    case good = 4
    case great = 5
    
//    var intValue: Int {
//        switch self {
//        case .awful:
//            return 1
//        case .bad:
//            return 2
//        case .norm:
//            return 3
//        case .good:
//            return 4
//        case .great:
//            return 5
//        }
//    }
    
    var stringValue: String {
        switch self {
        case .none:
            return "Ваша оценка"
        case .awful:
            return "Ужасно"
        case .bad:
            return "Плохо"
        case .norm:
            return "Нормально"
        case .good:
            return "Хорошо"
        case .great:
            return "Отлично"
        }
    }
}

struct Review {
    var product: Product
    var rating: RatingValue?
    var advantages: String?
    var disadvantages: String?
    var comment: String?
}

var testReview: Review = Review(product: testProducts[0])
