//
//  SummaryView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 15.12.2024.
//

import SwiftUI

struct PayButton: View {
    func pay() {
        
    }
    
    @State private var isPressed = false
    
    var body: some View {
        Button (action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                isPressed.toggle()
            }
            
            // Автоматическое "отжатие" кнопки с задержкой
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPressed = false
                }
            }
            
            pay()
        }) {
            ZStack {
                Rectangle()
                    .fill(isPressed ? .white : Color(r: 255, g: 70, b: 17, alpha: 1))
                    .cornerRadius(12)
                
                HStack(alignment: .center) {
                    Text("Оплатить")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

struct OrderSummaryView: View {
    @State var productsCount: Int = 2
    @State var productsPrice: Float = 1231230.1
    @State var discountSum: Float = 900
    //@ObservedObject viewModel: OrderSumViewModel
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                VStack(alignment: .center, spacing: 10) {
                    // Цена
                    HStack {
                        Text("Цена за \(productsCount) товара")
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                        Text("\(productsPrice)")
                            .font(.system(size: 14))
                            .bold()
                        
                    }
                    
                    // Скидки
                    HStack {
                        Text("Скидки")
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                        Text("\(discountSum)")
                            .font(.system(size: 14))
                            .foregroundStyle(Color(r: 255, g: 70, b: 17))
                            .bold()
                    }
                    
                    // Промокоды
                    HStack {
                        Text("Промокоды")
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                        Text("\(discountSum)")
                            .font(.system(size: 14))
                            .foregroundStyle(Color(r: 0, g: 183, b: 117))
                            .bold()
                    }
                    
                    // Способ оплаты
                    HStack {
                        Text("Способ оплаты")
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                        Text("\(discountSum)")
                            .font(.system(size: 14))
                            .bold()
                    }
                }
                
                Rectangle()
                    .frame(width: .infinity, height: 1)
                    .foregroundStyle(Color(r: 234, g: 234, b: 234))
                
                // Итог
                HStack {
                    Text("Итого")
                        .font(.system(size: 18))
                        .bold()
                    
                    Spacer()
                    
                    Text("19 000")
                        .font(.system(size: 18))
                        .bold()
                }
                
                
                PayButton()
            }
            
            .padding(.vertical, 24)
            .padding(.horizontal, 32)
        }
        .background(Color(r: 246, g: 246, b: 246))
    }
}

