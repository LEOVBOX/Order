//
//  StartWindowView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 13.12.2024.
//

import SwiftUI

struct StartWindowView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: RejectView()) {
                    Text("Отменить заказ")
                }
                NavigationLink(destination: OrderView(viewModel: OrderViewModel(order: testOrder))) {
                    Text("Заказ")
                }
            }
        }
    }
}

#Preview {
    StartWindowView()
}
