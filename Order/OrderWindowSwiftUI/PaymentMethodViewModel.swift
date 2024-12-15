//
//  PaymentMethodViewModel.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 15.12.2024.
//
import Foundation

class PaymentMethodViewModel: ObservableObject {
    @Published var logoImageName: String
    @Published var description: String
    @Published var discountPercent: Int
    
    var discountPercentString: String {
        return "-\(discountPercent)%"
    }
    
    @Published var name: String
    
    init(logoImageName: String, descriptioin: String, discountPercent: Int, name: String) {
        self.logoImageName = logoImageName
        self.description = descriptioin
        self.discountPercent = discountPercent
        self.name = name
    }
}

enum PaymentMethodOption {
    case tinkoffPay
    case sber
    case debetCard
    case yaPaySplit
    case tbankCredit
    case cash
    
    var value: PaymentMethodViewModel {
        switch self {
            
        case .tinkoffPay:
            return PaymentMethodViewModel(
                logoImageName: "tinkoffPay",
                descriptioin: "Через приложение Тилькофф",
                discountPercent: 5,
                name: "Tinkoff Pay"
                )
        case .sber:
            return PaymentMethodViewModel(
                logoImageName: "sber",
                descriptioin: "Через приложение СберБанк",
                discountPercent: 5,
                name: "Sber Pay"
                )
        case .debetCard:
            return PaymentMethodViewModel(
                logoImageName: "debetCard",
                descriptioin: "Visa, Master Card, МИР",
                discountPercent: 5,
                name: "Банковской картой"
                )
        case .yaPaySplit:
            return PaymentMethodViewModel(
                logoImageName: "yaPay",
                descriptioin: "Оплата частями",
                discountPercent: 5,
                name: "Яндекс Пэй со Сплитом"
                )
        case .tbankCredit:
            return PaymentMethodViewModel(
                logoImageName: "tinkoff",
                descriptioin: "На 3 месяца без переплат",
                discountPercent: 5,
                name: "Рассрочка Тинькофф"
                )
        case .cash:
            return PaymentMethodViewModel(
                logoImageName: "cash",
                descriptioin: "Наличными или картой",
                discountPercent: 5,
                name: "Оплатить при получени"
                )
        }
    }
}
