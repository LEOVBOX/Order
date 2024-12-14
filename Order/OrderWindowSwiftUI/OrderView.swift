//
//  OrderView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 13.12.2024.
//

import SwiftUI

struct PaymentMethodOptionView: View {
    @Binding var isSelected: Int?
    var optionIndex: Int
    // TODO: Брать информацию из viewModel
    var logoImage: Image = Image("sber")
    var name: String = "SberPay"
    var description: String = "Через приложение СберБанк"
    var discountPercent: String = "-5%"
    var body: some View {
        HStack {
            logoImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 24, height: 24)
            VStack(alignment: .leading, spacing: 0) {
                HStack (spacing: 4) {
                    Text(name)
                        .font(.system(size: 16))
                    Text(discountPercent)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.black)
                        .foregroundStyle(.white)
                        .cornerRadius(32)
                        .font(.system(size: 12))
                    
                }
                Text(description)
                    .font(.system(size: 14))
                    .foregroundStyle(Color(r: 122, g: 122, b: 122))
            }
            Spacer()
            
            Toggle(name, isOn: Binding(
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
        //.background(.red)
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
    var body: some View {
        VStack(alignment: .center) {
            PaymentMethodOptionView(isSelected: $selectedOption, optionIndex: 1)
        }
        .padding()
    }
}

struct OrderView: View {
    func showPrevView() {
        
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    // Состав заказа
                    OrderCompositionView()
                    PaymentMethod()
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
