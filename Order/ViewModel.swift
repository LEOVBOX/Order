//
//  ViewModel.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 27.10.2024.
//

import Foundation

class ViewModel {
    
    lazy var price: Double = 0
    lazy var promocodesDiscount: Double = 0
    lazy var discountPercent: Int = 0
    lazy var currentSumm: Double = 0
    
    // Closure для обновления интерфейса в ViewController
    var dataUpdated: (() -> Void)?
    
    // Closure для показа сообщения об ошибке в ViewController
    var showPromcodesCountAlert: (() -> Void)?
    
    var showPromocodesViewController: (() -> Void)?
    
    
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
        
        cellViewModels.append(.init(type: .button(.init(
            imageName: "Promocode",
            title: "Применить промокод",
            backgroundHexColor: "#FF46111A",
            titleHexColor: "#FF4611",
            action: showPromocodesViewController
        ))))
        
        // Добавляем все промокоды из заказа
        for promocode in order.promocodes {
            var promoViewModel = TableViewModel.ViewModelType.Promo(
                title: promocode.title,
                percent: promocode.percent,
                date: formattedDate(promocode.endDate),
                caution: promocode.info,
                isActive: promocode.active,
                toggle: togglePromo(value:id:)
            )
            
            // Увеличиваем скидку доступным количеством активных промокодов
            if (toggledPromoCells.count != productsCount) && (promoViewModel.isActive) {
                discountPercent += promocode.percent
                toggledPromoCells.append(promoViewModel)
            }
            else {
                promoViewModel.isActive = false
            }
            
            cellViewModels.append(.init(type: .promo(promoViewModel)))
        }
        
        cellViewModels.append(.init(type: .button(.init(imageName: nil, title: "Скрыть промокоды", backgroundHexColor: "#FF46100", titleHexColor: "#FF4611"))))
        
        // Calculate summ without discount
        for product in order.products {
            price += product.price
        }
        
        promocodesDiscount = price * (1 - Double(discountPercent) / 100)
        
        currentSumm = price - promocodesDiscount
        if let baseDiscount = order.baseDiscount {
            currentSumm -= baseDiscount
        }
        
        if let paymentDiscount = order.paymentDiscount {
            currentSumm -= paymentDiscount
        }
        
        let resultViewModel = TableViewModel.ViewModelType.Result(summ: currentSumm, productsCount: productsCount, baseDiscount: order.baseDiscount, promocodesDiscount: 0, paymentDiscount: 0, price: price)
        cellViewModels.append(.init(type: .result(resultViewModel)))
    }
    
    
    private func updateResultCell() {
        // Находим индекс ячейки Result в массиве cellViewModels
        guard let resultIndex = cellViewModels.firstIndex(where: { cellViewModel in
            if case .result = cellViewModel.type {
                return true
            }
            return false
        }) else { return }
        
        promocodesDiscount = 0
        
        // Вычисляем скидку от активных промокодов
        for promo in toggledPromoCells {
            promocodesDiscount += price * (Double(promo.percent) / 100.0)
        }
        
        currentSumm = price - promocodesDiscount
        
        // Находим текущую модель результата
        if case var .result(resultModel) = cellViewModels[resultIndex].type {
            // Пересчитываем итоговую цену с учетом базовой суммы и скидок
            if let baseDiscount = resultModel.baseDiscount {
                currentSumm -= baseDiscount
            }
            
            if let paymentDiscount = resultModel.paymentDiscount {
                currentSumm -= paymentDiscount
            }
            
            resultModel.summ = currentSumm
            resultModel.promocodesDiscount = promocodesDiscount
            
            // Обновляем ячейку Result с новыми данными
            cellViewModels[resultIndex].type = .result(resultModel)
            
            // Вызываем замыкание для обновления интерфейса
            dataUpdated?()
        }
    }
    
    private func togglePromo(value: Bool, id: String) {
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
            
            updateResultCell()
        default:
            break
        }
    }

        
}
