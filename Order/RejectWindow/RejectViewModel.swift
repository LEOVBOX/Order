//
//  RejectViewModel.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 13.12.2024.
//

import Foundation

class RejectViewModel: ObservableObject {
    @Published var rejectOptions: [String] = []
    
    @Published var isMoneyNotification: Bool = false
    
    init(rejectOptions: [String] = ["Не подходит дата получения",
                                    "Часть товаров из заказа была отменена",
                                    "Не получилось применить скидку или промокод",
                                    "Хочу изменить заказ и оформить заново",
                                    "Нашелся товар дешевле"],
         isMoneyNotification: Bool = false) {
        self.isMoneyNotification = isMoneyNotification
        self.rejectOptions = rejectOptions
    }
    
//    var rejectOptions: [String] = []
}
