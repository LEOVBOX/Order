//
//  ViewController.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 17.10.2024.
//

import UIKit

class ViewModel {
    
    // TODO: VM ячеек должны генерироватся из Order
    lazy var cellViewModels: [TableViewModel] = []

    
    func togglePromo(value: Bool, id: String) {
        let element = cellViewModels.first(where: { value in
            switch value.type {
            case .promo(let promo):
                if promo.id == id {
                    return true
                }
            default:
                return false
            }

            return false
        })
    }
}


class ViewController: UIViewController {

    let viewModel = ViewModel()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Оформление заказа"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()

    func showOrder(order: Order) {
        // Очищаем текущие данные
        viewModel.cellViewModels.removeAll()
        
        label.text = order.screenTitle

        // Добавляем информацию о промокодах
        viewModel.cellViewModels.append(.init(type: .info(.init(title: "Промокоды", info: "На один товар можно применить только один промокод"))))
        
        viewModel.cellViewModels.append(.init(type: .button(.init(image: UIImage(named: "Promocode"), title: "Применить промокод", backgroundHexColor: "#FF46111A", titleHexColor: "#FF4611"))))
        

        // Добавляем все промокоды из заказа
        for promocode in order.promocodes {
            let promoViewModel = TableViewModel.ViewModelType.Promo(
                title: promocode.title,
                percent: "\(promocode.percent)%",
                date: formattedDate(promocode.endDate),
                caution: promocode.info,
                isActive: promocode.active
            )
            viewModel.cellViewModels.append(.init(type: .promo(promoViewModel)))
        }
        
        
        
        viewModel.cellViewModels.append(.init(type: .button(.init(image: nil, title: "Скрыть промокоды", backgroundHexColor: "#FF46100", titleHexColor: "#FF4611"))))

       
        var summ: Double = 0
        var count = 0
        var price = summ
        
        for product in order.products {
            summ += product.price
            count+=1
        }
        
        let resultViewModel = TableViewModel.ViewModelType.Result(summ: summ, productsCount: count, baseDiscount: order.baseDiscount, promocodesDiscount: 0, paymentDiscount: 0, price: summ)
        viewModel.cellViewModels.append(.init(type: .result(resultViewModel)))

        tableView.reloadData()
    }
    
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hexString: "#F6F6F6")
        tableView.register(TitleCell.self, forCellReuseIdentifier: String(describing: TitleCell.self))
        tableView.register(PromoCell.self, forCellReuseIdentifier: String(describing: PromoCell.self))
        tableView.register(ButtonCell.self, forCellReuseIdentifier: String(describing: ButtonCell.self))
        tableView.register(ResultCell.self, forCellReuseIdentifier: String(describing: ResultCell.self))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var seporatorView: UIView = {
        let seporator = UIView()
        seporator.backgroundColor = UIColor(hexString: "#F6F6F6")
        return seporator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        view.addSubview(seporatorView)
        seporatorView.translatesAutoresizingMaskIntoConstraints = false
        seporatorView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        seporatorView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        seporatorView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        seporatorView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: seporatorView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        showOrder(order: testOrder)
        
    }
    
    @objc func tap() {
        print("tap")
    }
    
    @objc func textFieldChanged() {
        
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModel.cellViewModels[indexPath.row]
        
        switch viewModel.type {
        case .promo(let promo):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PromoCell.self)) as? PromoCell else {
                return UITableViewCell()
            }
            cell.viewModel = promo
            cell.selectionStyle = .none
            return cell
        
        case .info(let info):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleCell.self)) as? TitleCell else {
                return UITableViewCell()
            }
            cell.viewModel = info
            cell.selectionStyle = .none
            return cell
            
        case .result(let result):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultCell.self)) as? ResultCell else {
                return UITableViewCell()
            }
            cell.viewModel = result
            cell.selectionStyle = .none
            return cell
            
        case .button(let button):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ButtonCell.self)) as? ButtonCell else {
                return UITableViewCell()
            }
            
            cell.viewModel = button
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


struct TableViewModel {
    enum ViewModelType {
        struct Promo {
            let id: String = UUID().uuidString
            let title: String
            let percent: String
            let date: String
            let caution: String?
            let isActive: Bool
            let toggle: ((Bool, String) -> Void)?
            
            init(title: String, percent: String, date: String, caution: String? = nil, isActive: Bool, toggle: (((Bool, String) -> Void))? = nil) {
                self.title = title
                self.percent = percent
                self.caution = caution
                self.isActive = isActive
                self.toggle = toggle
                self.date = date
            }
        }
        
        struct TitleInfo {
            let title: String
            let info: String
        }
        
        struct Result {
            var summ: Double
            let productsCount: Int
            let baseDiscount: Double?
            var promocodesDiscount: Double
            let paymentDiscount: Double?
            let price: Double
        }
        
        struct Button {
            let image: UIImage?
            let title: String?
            let backgroundHexColor: String?
            let titleHexColor: String?
        }
        
        
        case info(TitleInfo)
        case promo(Promo)
        case result(Result)
        case button(Button)
    }

    var type: ViewModelType
}


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


