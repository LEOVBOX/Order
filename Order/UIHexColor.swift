//
//  UIHexColor.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 27.10.2024.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        // Очищаем строку от символов, которые не относятся к hex-формату
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let red, green, blue, alpha: CGFloat
        switch hex.count {
        case 6: // RGB (24-битный)
            red = CGFloat((int >> 16) & 0xFF) / 255.0
            green = CGFloat((int >> 8) & 0xFF) / 255.0
            blue = CGFloat(int & 0xFF) / 255.0
            alpha = 1.0 // Альфа по умолчанию
        case 8: // RGBA (32-битный)
            red = CGFloat((int >> 24) & 0xFF) / 255.0
            green = CGFloat((int >> 16) & 0xFF) / 255.0
            blue = CGFloat((int >> 8) & 0xFF) / 255.0
            alpha = CGFloat(int & 0xFF) / 255.0
        default:
            // Некорректный hex-код, возвращаем прозрачный цвет
            red = 1.0
            green = 1.0
            blue = 1.0
            alpha = 0.0
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // Функция для изменения яркости
    func adjustAlpha(by percentage: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Извлечение HSB компонентов цвета
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            // Изменяем яркость, ограничиваем диапазон от 0 до 1
            let newAlpha = min(max(alpha + percentage, 0.0), 1.0)
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: newAlpha)
        } else {
            // Если не удается получить HSB компоненты, возвращаем исходный цвет
            return self
        }
    }
    
    func alpha() -> CGFloat? {
        var brightness: CGFloat = 0
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Извлечение HSB компонентов цвета
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            // Возвращаем яркость в процентах
            return alpha
        }
        
        // Возвращаем nil, если не удалось извлечь HSB компоненты
        return nil
    }
    
}
