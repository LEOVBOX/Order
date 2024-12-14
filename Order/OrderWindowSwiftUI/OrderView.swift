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
                ScrollView {
                    // Состав заказа
                    OrderCompositionView()
                    
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
