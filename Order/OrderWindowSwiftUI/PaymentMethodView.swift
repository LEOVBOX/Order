//
//  PaymentMethodView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 15.12.2024.
//

import SwiftUI

struct PaymentMethodOptionView: View {
    @Binding var isSelected: Int?
    var optionIndex: Int
    @ObservedObject var viewModel: PaymentMethodViewModel
    var body: some View {
        ZStack {
            HStack {
                let logoImageName = viewModel.logoImageName
                Image(logoImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 24, height: 24)
                VStack(alignment: .leading, spacing: 0) {
                    HStack (spacing: 4) {
                        Text(viewModel.name)
                            .font(.system(size: 16))
                        Text(viewModel.discountPercentString)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(.black)
                            .foregroundStyle(.white)
                            .cornerRadius(32)
                            .font(.system(size: 12))
                        
                    }
                    Text(viewModel.description)
                        .font(.system(size: 14))
                        .foregroundStyle(Color(r: 122, g: 122, b: 122))
                }
                Spacer()
                
                
                Toggle(viewModel.name, isOn: Binding(
                    get: { isSelected == optionIndex },
                    set: { newValue in
                        if newValue {
                            isSelected = optionIndex
                        } else {
                            isSelected = nil
                        }
                    }
                ))
                
                .toggleStyle(CircleCheckboxToggleStyle())
                
                
            }
            
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(isSelected == optionIndex ? Color.white : Color.clear)
            .cornerRadius(12)
            .shadow( // Добавление тени при выборе
                color: isSelected == optionIndex ? Color.black.opacity(0.2) : Color.clear,
                radius: 5,
                x: 0,
                y: 0
            )
            .animation(.easeInOut(duration: 0.2), value: isSelected) // Анимация тени
            .onTapGesture {
                isSelected = optionIndex
            }
        }
       
    }
}

struct CircleCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            if configuration.isOn {
                Circle()
                    .stroke(Color(r:255, g: 70, b: 17), lineWidth: 2)
                    .frame(width: 18, height: 18)
                Circle()
                    .fill(Color(r: 255, g: 70, b: 17))
                    .frame(width: 8, height: 8)
            }
            else {
                Circle()
                    .stroke(Color(r: 122, g: 122, b: 122), lineWidth: 2)
                    .frame(width: 18, height: 18)
                
            }
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
        
    }
}

struct PaymentMethod: View {
    @State private var selectedOption: Int? = nil
    var viewModel: [PaymentMethodViewModel]
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Способ оплаты")
                .font(.system(size: 24))
                .bold()
            VStack(alignment: .center) {
                ForEach(viewModel.indices, id: \.self) { index in
                    PaymentMethodOptionView(
                        isSelected: $selectedOption,
                        optionIndex: index,
                        viewModel: viewModel[index]
                    )
                }
            }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
    }
}
