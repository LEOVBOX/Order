//
//  OrderView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 13.12.2024.
//

import SwiftUI
 
struct OrderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: OrderViewModel

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView (showsIndicators: false){
                    VStack(spacing: 0) {
                        // Состав заказа
                        ProductsListView(viewModel: self.viewModel)
                            //.background(.green)
                        
                        Rectangle()
                            .frame(height: 16)
                            .foregroundStyle(Color(r:246, g:246, b: 246))
                            
                        // Способы оплаты
                        PaymentMethod(viewModel: viewModel.paymentViewModels)
                        
                        Rectangle()
                            .frame(height: 16)
                            .foregroundStyle(Color(r:246, g:246, b: 246))
                        
                        // Список промокодов
                        PromocodesView(viewModel: self.viewModel)
                        
                        
                        // Итог
                        OrderSummaryView()
                    }
                }
                
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Оформление заказа")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem (placement: .navigation) {
                Button("BackButton", systemImage: "chevron.left", action: {
                    presentationMode.wrappedValue.dismiss()
                })
                    .tint(Color(r: 255, g: 70, b: 17))
            }
        }
    }
}

#Preview {
    OrderView(viewModel: OrderViewModel(order: testOrder))
}
