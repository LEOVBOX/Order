//
//  ReviewView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 16.12.2024.
//

import SwiftUI

struct ReviewUIKitWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ProductsViewController {
        return ProductsViewController()
    }
    
    func updateUIViewController(_ uiViewController: ProductsViewController, context: Context) {
        
    }
}

struct ReviewProductsListView: View {
    var body: some View {
        ReviewUIKitWrapper()
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Напишите отзыв", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton())
    }
}

