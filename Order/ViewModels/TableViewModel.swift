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
        class Promo: ObservableObject {
            let id: String = UUID().uuidString
            let toggle: ((Bool, String) -> Void)?
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
            
            init(name: String, discountPercent: Int, date: Date? = nil, description: String? = nil, isActive: Bool, toggle: ((Bool, String) -> Void)? = nil) {
                self.name = name
                self.discountPercent = discountPercent
                self.description = description
                self.isActive = isActive
                self.date = date
                self.toggle = toggle
            }
        }
        
        struct TitleInfo {
            let title: String
            let info: String
        }
        
        class Result: ObservableObject {
            @Published var summ: Double
            @Published var productsCount: Int
            @Published var baseDiscount: Double? = nil
            @Published var promocodesDiscount: Double
            @Published var paymentDiscount: Double? = nil
            @Published var price: Double
            
            init(summ: Double, productsCount: Int, baseDiscount: Double? = nil, promocodesDiscount: Double, paymentDiscount: Double? = nil, price: Double) {
                self.summ = summ
                self.productsCount = productsCount
                self.baseDiscount = baseDiscount
                self.promocodesDiscount = promocodesDiscount
                self.paymentDiscount = paymentDiscount
                self.price = price
            }
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
        
        class Product: ObservableObject {
            var title: String
            var imageUrl: String
            var size: Float?
            var count: Int
            var isListElement: Bool = false
            var price: Float
            var priceWithBaseDiscount: Float? {
                if baseDiscountPercent > 0 {
                    return price - price * Float(baseDiscountPercent) / 100
                }
                return nil
            }
            var baseDiscountPercent: Int
            
            var baseDiscountPercentString: String? {
                if baseDiscountPercent > 0 {
                    return "-\(baseDiscountPercent)%"
                }
                return nil
            }
            
            var sizeString: String? {
                guard let size = self.size else {
                    return nil
                }
                
                if size.truncatingRemainder(dividingBy: 1) != 0 {
                    return String(format: "%.1f", size)
                }
                
                return String(format: "%.0f", size)
                
            }
            
            var priceString: String? {
                let priceString = String(format: "%.2f", price)
                return priceString + " ₽"
            }
            
            var priceWithBaseDiscountString: String? {
                guard let priceWithBaseDiscount = self.priceWithBaseDiscount else {
                    return nil
                }
                
                let priceString = String(format: "%.2f", priceWithBaseDiscount)
                return priceString + " ₽"
            }
            
            init(title: String, imageUrl: String, size: Float? = nil, count: Int, isListElement: Bool = false, price: Float,
                 baseDiscountPercent: Int) {
                self.title = title
                self.imageUrl = imageUrl
                self.size = size
                self.count = count
                self.isListElement = isListElement
                self.price = price
                self.baseDiscountPercent = baseDiscountPercent
            }
            
        }
        
        struct Rating {
            var rating: RatingValue?
            init(rating: RatingValue? = nil) {
                self.rating = rating
            }
        }
        
        struct TextField {
            enum returnKeyType {
                case next
                case done
            }
            var text: String?
            let hint: String?
            var index: Int?
            var returnKeyType: returnKeyType?
        }
        
        struct Checkbox {
            var label: String?
            var isChecked: Bool = false
        }
        
        struct PhotoCollection {
            var imageNames: [String]
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
        case photoCollection(PhotoCollection)
    }

    var type: ViewModelType
}
