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
    @Published var isSelected: Bool
    
    var discountPercentString: String {
        return "-\(discountPercent)%"
    }
    
    @Published var name: String
    
    init(logoImageName: String, descriptioin: String, discountPercent: Int, name: String, isSelected: Bool = false) {
        self.logoImageName = logoImageName
        self.description = descriptioin
        self.discountPercent = discountPercent
        self.name = name
        self.isSelected = isSelected
    }
}
