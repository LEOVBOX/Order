//
//  OrderView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 13.12.2024.
//

import SwiftUI

struct PromocodeView: View {
    @ObservedObject var viewModel: PromocodeViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(r: 246, g: 246, b: 246))
                .cornerRadius(12)
                .frame(width: .infinity, height: .infinity)
            
            HStack {
                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.white)
                    .offset(x: -8)
                Spacer()
                
                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.white)
                    .offset(x: +8)
            }
                
                
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(viewModel.name)
                            .font(.system(size: 16))
                        Text(viewModel.discountPercentString)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color(r: 0, g: 183, b: 117))
                            .foregroundStyle(.white)
                            .cornerRadius(32)
                            .font(.system(size: 12))
                        
                        Button(action: {
                            
                        }) {
                            Image("infoButton")
                        }
                            
                        
                    }
                    if let dateString = viewModel.dateString {
                        Text(dateString)
                            .font(.system(size: 14))
                            .foregroundStyle(Color(r: 122, g: 122, b: 122))
                    }
                    
                    
                    if let description = viewModel.description {
                        Text(description)
                            .font(.system(size: 14))
                            .foregroundStyle(Color(r: 122, g: 122, b: 122))
                    }
                    
                    
                    
                }
                
                Spacer()
                
                Toggle(viewModel.name, isOn: $viewModel.isActive)
                .labelsHidden()
                
                .tint(Color(r: 255, g: 70, b: 17))
            }
            
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
        }
        
    }
}



struct PromocodesView: View {
    @State private var selectedOption: Int? = nil
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Промокоды")
                    .font(.system(size: 24))
                    .bold()
                Text("На один товар можно применить только один промокод")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(r: 122, g: 122, b: 122))
            }
            
            VStack(alignment: .center, spacing: 8) {
                PromocodeView(viewModel: PromocodeViewModel(name: "HELLO",
                                                            discountPercent: 5, date: Calendar.current.date(byAdding: .day, value: 10, to: Date()), description: "Промокод действует на первый заказ в приложении", isActive: false))
            }
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
    }
}

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
                        
                        Rectangle()
                            .frame(height: 16)
                            .foregroundStyle(Color(r:246, g:246, b: 246))
                        
                        PromocodesView()
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
