//
//  Order.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 17.10.2024.
//

import Foundation

struct Order {

    struct Promocode {

        let title: String

        let percent: Int

        let endDate: Date?

        let info: String?

        let active: Bool

    }

    var screenTitle: String

    var promocodes: [Promocode]
    
    var availableForActive: [Promocode]

    

    let products: [Product]

    let paymentDiscount: Double?

    let baseDiscount: Double?

}



let testOrder = Order(
    screenTitle: "Ваш заказ",
    promocodes: [
        Order.Promocode(
            title: "Промокод на 5% kljhkjhlkjhlkjhlkjhlkjhlkjhlkjhkljhlkjhlkjhlkjhkljh",
            percent: 5,
            endDate: Calendar.current.date(byAdding: .day, value: 10, to: Date()),
            info: "Скидка 5% на все товары",
            active: true
        ),
        Order.Promocode(
            title: "Промокод на 10%",
            percent: 10,
            endDate: Calendar.current.date(byAdding: .day, value: 20, to: Date()),
            info: "Скидка 10% на определенные товары",
            active: false
        ),
        Order.Promocode(
            title: "Промокод на 20%",
            percent: 10,
            endDate: Calendar.current.date(byAdding: .day, value: 20, to: Date()),
            info: "Скидка 10% на определенные товары",
            active: false
        )
    ],
    availableForActive: [
        Order.Promocode(
            title: "SUPERPROMO",
            percent: 50,
            endDate: Calendar.current.date(byAdding: .day, value: 10, to: Date()),
            info: "Скидка 50% на все товары",
            active: true
        ),
        Order.Promocode(
            title: "Промокод на 10%",
            percent: 10,
            endDate: Calendar.current.date(byAdding: .day, value: 20, to: Date()),
            info: "На кефир",
            active: false
        ),
        Order.Promocode(
            title: "Промокод на 20%",
            percent: 10,
            endDate: Calendar.current.date(byAdding: .day, value: 20, to: Date()),
            info: "Только на первый заказ",
            active: false
        )
    ],
    
    products: testProducts,
    paymentDiscount: 50.0,
    baseDiscount: 30.0
)
