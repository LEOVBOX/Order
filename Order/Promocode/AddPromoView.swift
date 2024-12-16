//
//  AddPromoView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 16.12.2024.
//

import SwiftUI

struct AddPromoUIKitWrapper: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: PromocodeViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> PromocodeViewController {
        return PromocodeViewController()
    }
}

struct AddPromoView: View {
    var body: some View {
        AddPromoUIKitWrapper()
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Применить промокод", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton())
    }
}

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(Color(red: 1, green: 70 / 255, blue: 17 / 255))
        }
    }
}
