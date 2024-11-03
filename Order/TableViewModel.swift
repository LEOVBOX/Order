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
            let percent: Int
            let date: String
            let caution: String?
            var isActive: Bool
            let toggle: ((Bool, String) -> Void)?
            
            init(title: String, percent: Int, date: String, caution: String? = nil, isActive: Bool, toggle: (((Bool, String) -> Void))? = nil) {
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
            let action: (() -> Void)?
            
            init (imageName: String? = nil, title: String? = nil, backgroundHexColor: String? = nil, titleHexColor: String? = nil, action: (() -> Void)? = nil) {
                self.imageName = imageName
                self.title = title
                self.backgroundHexColor = backgroundHexColor
                self.titleHexColor = titleHexColor
                self.action = action
            }
        }
        
        struct Input {
            var text: String
            var imageName: String?
            var isWarning: Bool
            let hintText: String?
            var buttonText: String?
            let action: ((String) -> Bool)?
        }
        
        struct Product {
            var title: String
            var imageName: String?
            var caption: String?
            var isArrawEnabled: Bool = true
        }
        
        struct Rating {
            var rating: RatingValue?
            init(rating: RatingValue? = nil) {
                self.rating = rating
            }
        }
        
        struct TextField {
            var text: String?
            let hint: String?
        }
        
        struct Checkbox {
            var isChecked: Bool = false
        }
        
        case info(TitleInfo)
        case promo(Promo)
        case result(Result)
        case button(Button)
        case input(Input)
        case product(Product)
        case rating(Rating)
        case textField(TextField)
        case checkBox(Checkbox)
    }

    var type: ViewModelType
}
