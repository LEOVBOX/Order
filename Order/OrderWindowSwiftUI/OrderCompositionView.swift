//
//  OrderCompositionView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 14.12.2024.
//

// View for presenting order composition (list of products)

import SwiftUI

struct OrderElement: View {
    //var viewModel: TableViewModel.ViewModelType.Product
    //var image: Image = Image("goldRind1")
    var name: String = "Золотое плоское обручальное кольцо 4 мм"
    var productInfo: String = "1 шт. • Размер: 17"
    var rawPrice: String? = "32 217 ₽"
    var discountPercent: String? = "-40%"
    var price: String = "26 642,40 ₽"
    
    
    var body: some View {
        HStack(alignment: .top) {
            Image("goldRing1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(.trailing, 12)
                .frame(width: 80, height: 80)
            
            // Description
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(size: 14))
                    Text(productInfo)
                        .foregroundStyle(Color(r: 122, g: 122, b: 122))
                        .font(.system(size: 14))
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    // Raw price and discount percent
                    if let rawPrice = rawPrice, let discountPercent = discountPercent {
                        HStack {
                            Text(rawPrice)
                                .font(.system(size: 14))
                                .strikethrough()
                                .foregroundStyle(Color(r: 122, g: 122, b: 122))
                            Text(discountPercent)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 1)
                                .background(Color(r: 255, g: 70, b: 17, alpha: 0.1))
                                .foregroundStyle(Color(r: 255, g: 70, b: 17))
                                .cornerRadius(6)
                                .font(.system(size: 12))
                        }
                    }
                    
                    Text(price)
                        .font(.system(size: 16))
                }
                
            }
        }
    }
}

struct OrderCompositionListView: View {
    var body: some View {
        VStack(spacing: 24) {
            OrderElement()
            OrderElement()
            OrderElement()
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        //.padding()
    }
}

struct OrderCompositionView: View {
    var body: some View {
        VStack(spacing: 16){
            OrderСompositionLabelView()
                
            OrderCompositionListView()
                
        }
        .padding()
    }
}

struct OrderСompositionLabelView: View {
    func goToCart() {
        
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text("Состав заказа")
                .font(.system(size: 24))
                .bold()
            VStack(alignment: .leading) {
                Text("Вы можете изменить параметры и состав заказа в ")
                    .foregroundStyle(Color(r: 122, g: 122, b: 122))
                    .font(.system(size: 14))
                Button(action: goToCart) {
                    Text("корзине")
                        .tint(Color(r: 255, g: 70, b: 17))
                        .font(.system(size: 14))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        //.padding()
    }
}
