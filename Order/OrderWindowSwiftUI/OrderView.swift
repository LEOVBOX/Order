//
//  OrderView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 13.12.2024.
//

import SwiftUI



struct OrderView: View {
    func showPrevView() {
        
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView (showsIndicators: false){
                    VStack(spacing: 0) {
                        // Состав заказа
                        OrderCompositionView()
                            //.background(.green)
                        
                        Rectangle()
                            .frame(height: 16)
                            .foregroundStyle(Color(r:246, g:246, b: 246))
                            
                        PaymentMethod(viewModel: [
                            PaymentMethodOption.sber.value,
                            PaymentMethodOption.debetCard.value,
                            PaymentMethodOption.yaPaySplit.value,
                            PaymentMethodOption.tbankCredit.value,
                            PaymentMethodOption.tinkoffPay.value,
                            PaymentMethodOption.cash.value
                        ])
                        //.background(.blue)
                    }
                }
            }
            .navigationTitle("Оформление заказа")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .navigation) {
                    Button("BackButton", systemImage: "chevron.left", action: showPrevView)
                        .tint(Color(r: 255, g: 70, b: 17))
                }
            }
            
        }
    }
}

#Preview {
    OrderView()
}
