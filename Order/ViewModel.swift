//
//  ViewModel.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 27.10.2024.
//

import Foundation

class ViewModel {
    
    // Closure для обновления интерфейса в ViewController
    var dataUpdated: (() -> Void)?
    
    // Closure для показа сообщения об ошибке в ViewController
    var showPromcodesCountAlert: (() -> Void)?
    
    
    lazy var productsCount = 0
    
    lazy var toggledPromoCells: [TableViewModel.ViewModelType.Promo] = []
    lazy var cellViewModels: [TableViewModel] = []
    
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    func createTable(order: Order) {
        productsCount = order.products.count
        
        // Добавляем информацию о промокодах
        cellViewModels.append(.init(type: .info(.init(title: "Промокоды", info: "На один товар можно применить только один промокод"))))
        
        cellViewModels.append(.init(type: .button(.init(imageName: "Promocode", title: "Применить промокод", backgroundHexColor: "#FF46111A", titleHexColor: "#FF4611"))))
        
        // Добавляем все промокоды из заказа
        for promocode in order.promocodes {
            let promoViewModel = TableViewModel.ViewModelType.Promo(
                title: promocode.title,
                percent: "\(promocode.percent)%",
                date: formattedDate(promocode.endDate),
                caution: promocode.info,
                isActive: promocode.active,
                toggle: togglePromo(value:id:)
            )
            
            if (toggledPromoCells.count == productsCount && promoViewModel.isActive) {
                var untogledPromoCell = toggledPromoCells.removeLast()
                untogledPromoCell.isActive = false
            }
            
            if (promoViewModel.isActive) {
                toggledPromoCells.append(promoViewModel)
            }
            
            cellViewModels.append(.init(type: .promo(promoViewModel)))
        }
        
        cellViewModels.append(.init(type: .button(.init(imageName: nil, title: "Скрыть промокоды", backgroundHexColor: "#FF46100", titleHexColor: "#FF4611"))))
       
        var summ: Double = 0
        
        for product in order.products {
            summ += product.price
        }
        
        
        let resultViewModel = TableViewModel.ViewModelType.Result(summ: summ, productsCount: productsCount, baseDiscount: order.baseDiscount, promocodesDiscount: 0, paymentDiscount: 0, price: summ)
        cellViewModels.append(.init(type: .result(resultViewModel)))
    }
    
    
    func togglePromo(value: Bool, id: String) {
        // Находим индекс нужного элемента в массиве
        var isActive = value
        guard let index = cellViewModels.firstIndex(where: { cellViewModel in
            switch cellViewModel.type {
            case .promo(let promo):
                return promo.id == id
            default:
                return false
            }
        }) else { return }
        
        if value == true && toggledPromoCells.count == productsCount {
            showPromcodesCountAlert?()
            isActive = !isActive
        }
        
        // Изменяем значение isActive у promo элемента
        var element = cellViewModels[index]
        switch element.type {
        case .promo(var promoModel):
            promoModel.isActive = isActive
            element.type = .promo(promoModel)
            
            // Обновляем элемент в массиве cellViewModels
            cellViewModels[index] = element
            
            // Добавляем в массив включенных промокодов
            if isActive == true {
                toggledPromoCells.append(promoModel)
            } else {
                // Удаляем элемент из toggledPromoCells, если он был выключен
                if let toggledIndex = toggledPromoCells.firstIndex(where: { $0.id == id }) {
                    toggledPromoCells.remove(at: toggledIndex)
                }
            }
            
            // Обновляем интерфейс
            dataUpdated?()
        default:
            break
        }
    }

        
}
