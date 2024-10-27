//
//  TableViewType.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 25.10.2024.
//

import Foundation

struct TableViewModel {
    // Models for table cells
    enum ViewModelType {
        struct Promo {
            let id: String = UUID().uuidString
            let title: String
            let percent: String
            let date: String
            let caution: String?
            var isActive: Bool
            let toggle: ((Bool, String) -> Void)?
            
            init(title: String, percent: String, date: String, caution: String? = nil, isActive: Bool, toggle: (((Bool, String) -> Void))? = nil) {
                self.title = title
                self.percent = percent
                self.caution = caution
                self.isActive = isActive
                self.toggle = toggle
                self.date = date
            }
        }
        
        struct TitleInfo {
            let title: String
            let info: String
        }
        
        struct Result {
            var summ: Double
            let productsCount: Int
            let baseDiscount: Double?
            var promocodesDiscount: Double
            let paymentDiscount: Double?
            let price: Double
        }
        
        struct Button {
            let imageName: String?
            let title: String?
            let backgroundHexColor: String?
            let titleHexColor: String?
        }
        
        
        case info(TitleInfo)
        case promo(Promo)
        case result(Result)
        case button(Button)
    }

    var type: ViewModelType
}
