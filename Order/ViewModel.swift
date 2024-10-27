//
//  ViewModel.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 27.10.2024.
//

import Foundation

class ViewModel {
    lazy var cellViewModels: [TableViewModel] = []
    
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    func createTable(order: Order) {
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
                isActive: promocode.active
            )
            cellViewModels.append(.init(type: .promo(promoViewModel)))
        }
        
        cellViewModels.append(.init(type: .button(.init(imageName: nil, title: "Скрыть промокоды", backgroundHexColor: "#FF46100", titleHexColor: "#FF4611"))))
       
        var summ: Double = 0
        var count = 0
        
        for product in order.products {
            summ += product.price
            count+=1
        }
        
        let resultViewModel = TableViewModel.ViewModelType.Result(summ: summ, productsCount: count, baseDiscount: order.baseDiscount, promocodesDiscount: 0, paymentDiscount: 0, price: summ)
        cellViewModels.append(.init(type: .result(resultViewModel)))
    }

    
    func togglePromo(value: Bool, id: String) {
        // Находим viewModel ячейки
        let element = cellViewModels.first(where: { value in
            switch value.type {
            case .promo(let promo):
                if promo.id == id {
                    return true
                }
            default:
                return false
            }

            return false
        })
        
        if let promoCell = element {
            
        }
        
    }
}
