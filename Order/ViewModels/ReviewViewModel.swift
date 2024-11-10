//
//  RatingViewModel.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 03.11.2024.
//

import Foundation

class ReviewViewModel {
    lazy var cellViewModels: [TableViewModel] = []
    
    var dataUpdated: (() -> Void)?
    
    func createTable(review: Review) {
        // product
        cellViewModels.append(.init(type: .product(.init(title: review.product.title, imageName: review.product.imageName, caption: review.product.captionText, isArrawEnabled: false))))
        
        // rating
        cellViewModels.append(.init(type: .rating(.init(rating: review.rating))))
        
        cellViewModels.append(.init(type: .photoCollection(.init(imageNames: ["hand1", "hand2", "hand3", "hand4", "hand5", "hand6", "hand7"]))))
        
        // START TEXT FIELDS INIT
        var textFieldStartIndex = cellViewModels.count
        
        // advantages
        cellViewModels.append(.init(type: .textField(.init(text: review.advantages, hint: "Достоинства", index: cellViewModels.count - textFieldStartIndex))))
        
        // disadvantages
        cellViewModels.append(.init(type: .textField(.init(text: review.disadvantages, hint: "Недостатки", index: cellViewModels.count - textFieldStartIndex))))
        
        // comment
        cellViewModels.append(.init(type: .textField(.init(text: review.comment, hint: "Комментарий", index: cellViewModels.count - textFieldStartIndex))))
        
        // END TEXT FIELDS INIT
        
        // checkbox
        cellViewModels.append(.init(type: .checkBox(.init(label: "Оставить отзыв анонимно", isChecked: false))))
        
        // send button
        cellViewModels.append(.init(type: .button(.init(title: "Отрпавить", backgroundHexColor: "#FF4611"))))
    }
}
