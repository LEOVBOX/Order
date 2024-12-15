//
//  PromocodeViewModel.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 15.12.2024.
//

import Foundation

class PromocodeViewModel: ObservableObject {
    var name: String
    var discountPercent: Int
    var discountPercentString: String {
        return "-\(discountPercent)%"
    }
    var date: Date?
    var dateString: String? {
        guard let date = date else {
            return nil
        }
        
        let formatter = DateFormatter()

        formatter.dateFormat = "MMMM"
        formatter.locale = Locale(identifier: "ru_RU")

        let monthName = formatter.string(from: date)
        
        let formatedMonthName: String = {
            switch monthName {
            case "январь":
                 return "января"
            case "февраль":
                return "февраля"
            case "март":
                return "марта"
            case "апрель":
                return "апреля"
            case "май":
                return "мая"
            case "июнь":
                return "июня"
            case "июль":
                return "июля"
            case "август":
                return "августа"
            case "сентябрь":
                return "сентября"
            case "октябрь":
                return "октября"
            case "ноябрь":
                return "ноября"
            case "декабрь":
                return "декабря"
            default:
                return monthName
            }
        }()
        
        formatter.dateFormat = "dd"
        let dayString = formatter.string(from: date)
        
        return "По \(dayString) \(String(describing: formatedMonthName))"
    }
    
    var description: String?
    @Published var isActive: Bool
    
    init(name: String, discountPercent: Int, date: Date? = nil, description: String? = nil, isActive: Bool) {
        self.name = name
        self.discountPercent = discountPercent
        self.description = description
        self.isActive = isActive
        self.date = date
    }
}
