//
//  PromocodesView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 15.12.2024.
//

import SwiftUI

struct PromocodeView: View {
    @ObservedObject var viewModel: TableViewModel.ViewModelType.Promo
    
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
                
            VStack(alignment: .leading) {
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
                    }
                    
                    Spacer()
                    
                    Toggle(viewModel.name, isOn: $viewModel.isActive)
                    .labelsHidden()
                    
                    .tint(Color(r: 255, g: 70, b: 17))
                }
                
                if let description = viewModel.description {
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundStyle(Color(r: 122, g: 122, b: 122))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
        }
        
    }
}


struct PromocodeApplyButton: View {
    func openPromoInput() {
        
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
            
            openPromoInput()
        }) {
            ZStack {
                Rectangle()
                    .fill(isPressed ? .white : Color(r: 255, g: 70, b: 17, alpha: 0.1))
                    .cornerRadius(12)
                
                HStack(alignment: .center) {
                    Image("Promocode")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .aspectRatio(contentMode: .fill)
                    Text("Применить промокод")
                        .font(.system(size: 16))
                        .foregroundStyle(Color(r: 255, g: 70, b: 17))
                }
                .padding(.vertical, 16)
            }
        }
    }
}

struct HidePromocodesButton: View {
    func hidePromocodes() {
        
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
            
            hidePromocodes()
        }) {
            Text("Скрыть промокоды")
                .font(.system(size: 16))
                .foregroundStyle(isPressed ? Color(r: 255, g: 70, b: 17, alpha: 0.1) : Color(r: 255, g: 70, b: 17, alpha: 1))
                .bold()
        }
        .padding(.vertical, 9)
        .padding(.horizontal, 16)
    }
}



struct PromocodesView: View {
    @State private var selectedOption: Int? = nil
    
    @ObservedObject var viewModel: OrderViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Промокоды")
                    .font(.system(size: 24))
                    .bold()
                Text("На один товар можно применить только один промокод")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(r: 122, g: 122, b: 122))
            }
            
            PromocodeApplyButton()
            
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(viewModel.promoViewModels.indices, id: \.self) { index in
                    PromocodeView(viewModel: viewModel.promoViewModels[index])
                }
                HidePromocodesButton()
            }
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
    }
}
