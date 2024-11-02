//
//  ProductsViewModel.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 01.11.2024.
//

import Foundation

class ProductsViewModel {
    var dataUpdated: (() -> Void)?
    lazy var cellViewModels: [TableViewModel] = []
    
    func createTable(products: [Product]) {
        for product in products {
            cellViewModels.append(.init(type: .product(.init(title: product.title, imageName: product.imageName ?? nil))))
        }
        
    }
}
