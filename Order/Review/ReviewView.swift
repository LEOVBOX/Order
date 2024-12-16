//
//  ReviewView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 16.12.2024.
//

import SwiftUI

struct ReviewUIKitWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ReviewViewController {
        return ReviewViewController()
    }
    
    func updateUIViewController(_ uiViewController: ReviewViewController, context: Context) {
        
    }
}

struct ReviewView: View {
    var body: some View {
        ReviewUIKitWrapper()
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Напишите отзыв", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton())
    }
}

