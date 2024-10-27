//
//  PromocodeViewModel.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 28.10.2024.
//

import Foundation

class PromocodeViewModel {
    var dataUpdated: (() -> Void)?
    
    private func checkAvailablePromocode(promocodeTitle: String) -> Bool {
        if order.availableForActive.contains(where: { promocode in
            promocode.title == promocodeTitle
        }) {
            return true
        }
        else {
            return false
        }
    }
    
    private func getTextFieldCellViewModel() -> TableViewModel? {
        return cellViewModels.first(where: { value in
            switch value.type {
            case .textField:
                return true
            default:
                return false
            }
        })
    }
    
    func applyPromocode() {
        guard let textField = getTextFieldCellViewModel() else {
            return
        }
        let textFieldViewModel: TableViewModel.ViewModelType.Text? = {
            switch textField.type {
            case .textField(let textFieldViewModel):
                return textFieldViewModel
            default:
                return nil
            }
        }()
        
        guard var textFieldViewModel = textFieldViewModel else {
            return
        }
        
        // wrong promocode
        if !checkAvailablePromocode(promocodeTitle: textFieldViewModel.text) {
            textFieldViewModel.isWarning = true
        }
        else {
            textFieldViewModel.isWarning = false
        }
    }
    
    private lazy var order = testOrder
    
    lazy var cellViewModels: [TableViewModel] = []
    lazy var textFieldCell: TableViewModel? = nil
    
    func createTable() {
        cellViewModels.append(.init(type: .textField(.init(text: "", imageName: "clearButton", isWarning: false))))
        cellViewModels.append(.init(type: .button(.init(
            title: "Применить",
            backgroundHexColor: "#FF4611",
            titleHexColor: "#FFFFFF",
            action: applyPromocode
        ))))
    }
    
}
