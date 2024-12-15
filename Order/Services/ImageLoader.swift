//  ImageLoader.swift
//  Images
//
//  Created by Леонид Шайхутдинов on 24.11.2024.
//
import Foundation
import UIKit
import SwiftUI
import Combine

class ImageLoader {
    private var activeRequests = [NSString: [((UIImage?) -> Void)]]()
    static let shared = ImageLoader()
    
    func findImageId(urlString: String) -> String? {
        let pattern = "/img/(\\d+)/"
        
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let range = NSRange(urlString.startIndex..<urlString.endIndex, in: urlString)
            if let match = regex.firstMatch(in: urlString, options: [], range: range) {
                if let imageNumberRange = Range(match.range(at: 1), in: urlString) {
                    let imageNumber = String(urlString[imageNumberRange])
                    return imageNumber
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
        return nil
    }

    func fetchImage(url: String) -> AnyPublisher<UIImage, Error> {
        guard let imageURL = URL(string: url) else {
            return Fail<UIImage, Error>(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        let imageId = findImageId(urlString: url)
        
        return CacheStorage.shared.getImage(forKey: imageId ?? "nil")
            .flatMap { image -> AnyPublisher<UIImage, Error> in
                if let image = image {
                    // Картинка найдена в кэше
                    //print("Изображение id: \(id) загружено из кэша")
                    return Just(image)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                            // Картинка не найдена, скачиваем с сервера
                            return URLSession.shared.dataTaskPublisher(for: imageURL)
                                .tryMap { data, response -> UIImage in
                                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                                        throw URLError(.badServerResponse)
                                    }
                                    guard let image = UIImage(data: data) else {
                                        throw URLError(.cannotDecodeContentData)
                                    }
                                    //print("Изображение id: \(id) загружено с сервера")
                                    // Сохраняем изображение на диск
                                    if let imageId = imageId {
                                        let fileName = "\(imageId)"
                                        CacheStorage.shared.saveImage(image, forKey: fileName)
                                    }
                                    
                                    return image
                                }
                                .eraseToAnyPublisher()
                            }
                        }
                        .eraseToAnyPublisher()
    }
    
    func fetchImageForSwiftUI(url: String) -> AnyPublisher<Image, Error> {
        guard let imageURL = URL(string: url) else {
            return Fail<Image, Error>(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        let imageId = findImageId(urlString: url)
        
        return CacheStorage.shared.getImage(forKey: imageId ?? "nil")
            .flatMap { image -> AnyPublisher<Image, Error> in
                if let image = image {
                    // Картинка найдена в кэше
                    let swiftUIImage = Image(uiImage: image)
                    return Just(swiftUIImage)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                    // Картинка не найдена, скачиваем с сервера
                    return URLSession.shared.dataTaskPublisher(for: imageURL)
                        .tryMap { data, response -> Image in
                            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                                throw URLError(.badServerResponse)
                            }
                            guard let uiImage = UIImage(data: data) else {
                                throw URLError(.cannotDecodeContentData)
                            }
                            // Сохраняем изображение на диск
                            if let imageId = imageId {
                                let fileName = "\(imageId)"
                                CacheStorage.shared.saveImage(uiImage, forKey: fileName)
                            }
                            return Image(uiImage: uiImage)
                        }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

