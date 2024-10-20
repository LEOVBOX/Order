//
//  ResultCell.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 20.10.2024.
//

import UIKit

class ResultCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.Result? {
        didSet {
            updateUI()
        }
    }
    
    var bgColor: UIColor?
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Оформление заказа", for: .normal) 
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside])
        button.backgroundColor = UIColor(hexString: "#FF4611")
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 12
        return button
    }()
    
    @objc func buttonPressed() {
        UIView.animate(withDuration: 0.3) {
            if let alphaValue = self.bgColor?.alpha() {
                if (alphaValue >= 0.5) {
                    self.button.backgroundColor = self.button.backgroundColor?.adjustAlpha(by: -0.5)
                }
                else {
                    self.button.backgroundColor = self.button.backgroundColor?.adjustAlpha(by: 0.5)
                }
            }
            
        }
    }
    
    @objc func buttonReleased() {
        UIView.animate(withDuration: 0.3) {
            if let color = self.bgColor {
                self.button.backgroundColor = color
            }
        }
    }

    
    lazy var priceHeader: UILabel = {
        let label = UILabel()
        label.text = "Цена за 2 товара"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    lazy var priceValue: UILabel = {
        let label = UILabel()
        label.text = "25 000 ₽"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    lazy var discountHeader: UILabel = {
        let label = UILabel()
        label.text = "Скидки"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    lazy var discountValue: UILabel = {
        let label = UILabel()
        label.text = "-5 000 ₽"
        label.textColor = UIColor(hexString: "#FF4611")
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    lazy var promocodesHeader: UILabel = {
        let label = UILabel()
        label.text = "Промокоды"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    lazy var promocodesValue: UILabel = {
        let label = UILabel()
        label.text = "-5 000 ₽"
        label.textColor = UIColor(hexString: "#00B775")
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    lazy var paymentDiscountHeader: UILabel = {
        let label = UILabel()
        label.text = "Способо оплаты"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    lazy var paymentDiscountValue: UILabel = {
        let label = UILabel()
        label.text = "-5 000 ₽"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    
    lazy var summHeader: UILabel = {
        let label = UILabel()
        label.text = "Итого"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 18)
        return label
    }()
    
    lazy var summValue: UILabel = {
        let label = UILabel()
        label.text = "19 000 ₽"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 18)
        return label
    }()
    
    
    private func updateUI() {
        guard let viewModel else {
            return
        }
        
        priceValue.text = "\(viewModel.price)"
        promocodesValue.text = "\(viewModel.promocodesDiscount)"
        if let baseDiscount = viewModel.baseDiscount {
            discountValue.text = "\(baseDiscount)"
        }
        
        if let paymentDiscount = viewModel.paymentDiscount {
            paymentDiscountValue.text = "\(paymentDiscount)"
        }
        
        priceHeader.text = "Цена за \(viewModel.productsCount) продукта"
        
        summValue.text = "\(viewModel.summ)"
    }
    
    
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(hexString: "#F6F6F6")
        contentView.addSubview(priceHeader)
        priceHeader.translatesAutoresizingMaskIntoConstraints = false
        
        priceHeader.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
        priceHeader.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32).isActive = true
        
        contentView.addSubview(priceValue)
        priceValue.translatesAutoresizingMaskIntoConstraints = false
        
        priceValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
        priceValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32).isActive = true
        
        contentView.addSubview(discountHeader)
        discountHeader.translatesAutoresizingMaskIntoConstraints = false
        
        discountHeader.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32).isActive = true
        discountHeader.topAnchor.constraint(equalTo: priceHeader.bottomAnchor, constant: 10).isActive = true
        
        contentView.addSubview(discountValue)
        discountValue.translatesAutoresizingMaskIntoConstraints = false
        
        discountValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32).isActive = true
        discountValue.topAnchor.constraint(equalTo: priceValue.bottomAnchor, constant: 10).isActive = true
        
        contentView.addSubview(promocodesHeader)
        promocodesHeader.translatesAutoresizingMaskIntoConstraints = false
        
        promocodesHeader.topAnchor.constraint(equalTo: discountHeader.bottomAnchor, constant: 10).isActive = true
        promocodesHeader.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32).isActive = true
        
        contentView.addSubview(promocodesValue)
        promocodesValue.translatesAutoresizingMaskIntoConstraints = false
        
        promocodesValue.topAnchor.constraint(equalTo: discountValue.bottomAnchor, constant: 10).isActive = true
        promocodesValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32).isActive = true
        
        contentView.addSubview(paymentDiscountHeader)
        paymentDiscountHeader.translatesAutoresizingMaskIntoConstraints = false
        
        paymentDiscountHeader.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32).isActive = true
        paymentDiscountHeader.topAnchor.constraint(equalTo: promocodesHeader.bottomAnchor, constant: 10).isActive = true
        
        contentView.addSubview(paymentDiscountValue)
        paymentDiscountValue.translatesAutoresizingMaskIntoConstraints = false
        
        paymentDiscountValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32).isActive = true
        paymentDiscountValue.topAnchor.constraint(equalTo: promocodesValue.bottomAnchor, constant: 10).isActive = true
        
        
        
        contentView.addSubview(summHeader)
        summHeader.translatesAutoresizingMaskIntoConstraints = false
        
        
        summHeader.topAnchor.constraint(equalTo: paymentDiscountHeader.bottomAnchor, constant: 32).isActive = true
        summHeader.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32).isActive = true
        
        contentView.addSubview(summValue)
        summValue.translatesAutoresizingMaskIntoConstraints = false
        
        summValue.topAnchor.constraint(equalTo: paymentDiscountValue.bottomAnchor, constant: 32).isActive = true
        summValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32).isActive = true
        
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.topAnchor.constraint(equalTo: summValue.bottomAnchor, constant: 16).isActive = true
        button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32).isActive = true
        button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32).isActive = true
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
