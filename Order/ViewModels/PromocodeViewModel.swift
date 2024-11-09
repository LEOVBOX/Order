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
    var showMainVC: ((Order) -> Void)?
    
    private func checkAvailablePromocode(promocodeTitle: String) -> Order.Promocode? {
        if let promocode = order.availableForActive.first(where: { promocode in
            promocode.title == promocodeTitle
        }) {
            return promocode
        }
        else {
            return nil
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
        if let promocode = checkAvailablePromocode(promocodeTitle: textFieldViewModel.text) {
            textFieldViewModel.isWarning = false
            order.promocodes.append(promocode)
            order.availableForActive.removeAll(where: { promocode in
                promocode.title == promocode.title
            })
            showMainVC?(order)
            
            return true
        }
        else {
            textFieldViewModel.isWarning = true
            return false
        }
    }
    
    private lazy var order = testOrder
    
    lazy var cellViewModels: [TableViewModel] = []
    lazy var textFieldCell: TableViewModel? = nil
    
    func createTable() {
        cellViewModels.append(.init(type: .input(.init(text: "", imageName: "clearButton", isWarning: false, hintText: "Введите код", action: applyPromocode))))
    }
    
}
