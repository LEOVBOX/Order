//
//  OrderCompositionView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 14.12.2024.
//

// View for presenting order composition (list of products)

import SwiftUI
import Combine

struct ProductView: View {
    @ObservedObject var viewModel: TableViewModel.ViewModelType.Product
    @State private var loadedImage: Image? = nil
    @State private var cancellable: AnyCancellable?
    @State private var errorMessage: String?
    
    private func loadImage() {
        cancellable = ImageLoader.shared.fetchImageForSwiftUI(url: viewModel.imageUrl)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { image in
                    self.loadedImage = image
                })
        }
    
    var body: some View {
        HStack(alignment: .top) {
            
            if let image = loadedImage {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 12)
            } else if let errorMessage = errorMessage {
                Text("Ошибка: \(errorMessage)")
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 12)
            } else {
                ProgressView()
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 12)
            }
            
            // Description
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(viewModel.title)
                        .font(.system(size: 14))
                    
                
                    if let size = viewModel.sizeString {
                        Text("\(viewModel.count) шт. • Размер: "+size)
                            .foregroundStyle(Color(r: 122, g: 122, b: 122))
                            .font(.system(size: 14))
                    }
                    else {
                        Text("\(viewModel.count) шт.")
                            .foregroundStyle(Color(r: 122, g: 122, b: 122))
                            .font(.system(size: 14))
                    }
                    
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    
                    // Raw price and discount percent
                    HStack {
                        if let price = viewModel.priceString {
                            Text(price)
                                .font(.system(size: 14))
                                .strikethrough()
                                .foregroundStyle(Color(r: 122, g: 122, b: 122))
                        }
                        
                        
                        if let discountPercentString = viewModel.baseDiscountPercentString {
                            Text(discountPercentString)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 1)
                                .background(Color(r: 255, g: 70, b: 17, alpha: 0.1))
                                .foregroundStyle(Color(r: 255, g: 70, b: 17))
                                .cornerRadius(6)
                                .font(.system(size: 12))
                        }
                    }
                    
                    if let discountedPrice = viewModel.priceWithBaseDiscountString {
                        Text(discountedPrice)
                            .font(.system(size: 16))
                        
                    }
                    
                    
                }
                
            }
            .onAppear {
                loadImage()
            }
            .onDisappear {
                cancellable?.cancel()
            }
        }
        
    }
}

struct ProductsListView: View {
    @ObservedObject var viewModel: OrderViewModel
    var body: some View {
        VStack(spacing: 16){
            OrderСompositionLabelView()
            
            VStack(alignment: .leading, spacing: 24) {
                ForEach(viewModel.productsViewModels.indices, id: \.self) { index in
                    ProductView(viewModel: viewModel.productsViewModels[index])
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
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
