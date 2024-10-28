//
//  PromocodeViewModel.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 28.10.2024.
//

import Foundation

class PromocodeViewModel {
    var dataUpdated: (() -> Void)?
    var showWarining: (() -> Void)?
    
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
            case .input:
                return true
            default:
                return false
            }
        })
    }
    
    func applyPromocode(promocodeTitle: String) -> Bool{
        guard let textField = getTextFieldCellViewModel() else {
            return false
        }
        let textFieldViewModel: TableViewModel.ViewModelType.Input? = {
            switch textField.type {
            case .input(let textFieldViewModel):
                return textFieldViewModel
            default:
                return nil
            }
        }()
        
        guard var textFieldViewModel = textFieldViewModel else {
            return false
        }
        
        textFieldViewModel.text = promocodeTitle
        
        // wrong promocode
        if !checkAvailablePromocode(promocodeTitle: textFieldViewModel.text) {
            textFieldViewModel.isWarning = true
            return false
        }
        else {
            textFieldViewModel.isWarning = false
            return true
        }
    }
    
    private lazy var order = testOrder
    
    lazy var cellViewModels: [TableViewModel] = []
    lazy var textFieldCell: TableViewModel? = nil
    
    func createTable() {
        cellViewModels.append(.init(type: .input(.init(text: "", imageName: "clearButton", isWarning: false, hintText: "Введите код", action: applyPromocode))))
    }
    
}
