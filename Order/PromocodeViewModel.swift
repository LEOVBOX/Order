//
//  PromocodeViewModel.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 28.10.2024.
//

import Foundation

class PromocodeViewModel {
    var dataUpdated: (() -> Void)?
    
    lazy var cellViewModels: [TableViewModel] = []
    
    func createTable() {
        cellViewModels.append(.init(type: .textField(.init(text: "", imageName: "clearButton"))))
        cellViewModels.append(.init(type: .button(.init(
            title: "Применить",
            backgroundHexColor: "#FF4611",
            titleHexColor: "#FFFFFF",
            action: dataUpdated
        ))))
    }
    
}
