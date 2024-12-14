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
    
    private var bgColor: UIColor?
    
    lazy var summaryVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.setTitle("Оформление заказа", for: .normal)
        button.backgroundColor = UIColor(hexString: "#FF4611")
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(makeOrderTapAnimation), for: .touchUpInside)
        return button
    }()
    
    @objc func makeOrderTapAnimation() {
        UIView.animate(withDuration: 0.3,
            animations: {
                self.button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.button.transform = CGAffineTransform.identity
                }
            })
    }
    
    lazy var seporatorLine: UIView = {
        let seporatorLine = UIView()
        seporatorLine.backgroundColor = UIColor(hexString: "#EAEAEA")
        return seporatorLine
    }()
    
    lazy var priceView = UIView()
    lazy var discountView = UIView()
    lazy var promocodesDiscountView = UIView()
    lazy var paymentDiscountView = UIView()
    lazy var summView = UIView()

    
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
    
    lazy var oferteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        let fullText = "Нажимая кнопку «Оформить заказ»,\nВы соглашаетесь с Условиями оферты"
        let attributedText = NSMutableAttributedString(string: fullText)

        // Указываем стиль для всей строки
        attributedText.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: fullText.count))
        attributedText.addAttribute(.font, value: UIFont(name: "Roboto", size: 12) ?? .systemFont(ofSize: 12), range: NSRange(location: 0, length: fullText.count))

        // Указываем стиль для кликабельного текста
        let linkTextRange = (fullText as NSString).range(of: "Условиями оферты")
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: linkTextRange)
        attributedText.addAttribute(.font, value: UIFont(name: "Roboto", size: 12) ?? .systemFont(ofSize: 12), range: linkTextRange)

        label.attributedText = attributedText

        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnTerms))
        //label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    lazy var oferteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Условиями оферты", for: .normal)
        button.addTarget(self, action: #selector(tapAnimation), for: .touchUpInside)
        return button
    }()
    
    @objc func tapAnimation() {
        UIView.animate(withDuration: 0.3,
            animations: {
                self.button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.button.transform = CGAffineTransform.identity
                }
            })
    }
    
    
    
    
    private func updateUI() {
        guard let viewModel else {
            return
        }
        
        priceValue.text = "\(viewModel.price) ₽"
        promocodesValue.text = "\(viewModel.promocodesDiscount) ₽"
        if let baseDiscount = viewModel.baseDiscount {
            discountValue.text = "\(baseDiscount) ₽"
        }
        
        if let paymentDiscount = viewModel.paymentDiscount {
            paymentDiscountValue.text = "\(paymentDiscount) ₽"
        }
        
        priceHeader.text = "Цена за \(viewModel.productsCount) продукта"
        
        summValue.text = "\(viewModel.summ) ₽"
    }
    
    lazy var mainView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hexString: "#F6F6F6")
        return view
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupUI() {
        
        contentView.backgroundColor = UIColor(hexString: "#F6F6F6")
        
        // summaryVerticalStackView constraints
        contentView.addSubview(summaryVerticalStackView)
        summaryVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryVerticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            summaryVerticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            summaryVerticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32)
        ])
        summaryVerticalStackView.spacing = 10
        
        // price
        priceView.translatesAutoresizingMaskIntoConstraints = false
        priceView.addSubview(priceHeader)
        priceHeader.translatesAutoresizingMaskIntoConstraints = false
        priceHeader.leadingAnchor.constraint(equalTo: priceView.leadingAnchor).isActive = true
        
        priceView.addSubview(priceValue)
        priceValue.translatesAutoresizingMaskIntoConstraints = false
        priceValue.trailingAnchor.constraint(equalTo: priceView.trailingAnchor).isActive = true
        priceView.heightAnchor.constraint(equalTo: priceValue.heightAnchor).isActive = true
        
        summaryVerticalStackView.addArrangedSubview(priceView)
        
        // discount
        discountView.translatesAutoresizingMaskIntoConstraints = false
        discountView.addSubview(discountHeader)
        discountHeader.translatesAutoresizingMaskIntoConstraints = false
        discountHeader.leadingAnchor.constraint(equalTo: discountView.leadingAnchor).isActive = true
        
        discountView.addSubview(discountValue)
        discountValue.translatesAutoresizingMaskIntoConstraints = false
        discountValue.trailingAnchor.constraint(equalTo: discountView.trailingAnchor).isActive = true
        discountView.heightAnchor.constraint(equalTo: discountValue.heightAnchor).isActive = true
        
        summaryVerticalStackView.addArrangedSubview(discountView)
        
        // promocodes discount
        promocodesDiscountView.translatesAutoresizingMaskIntoConstraints = false
        promocodesDiscountView.addSubview(promocodesHeader)
        promocodesHeader.translatesAutoresizingMaskIntoConstraints = false
        promocodesHeader.leadingAnchor.constraint(equalTo: promocodesDiscountView.leadingAnchor).isActive = true
        
        promocodesDiscountView.addSubview(promocodesValue)
        promocodesValue.translatesAutoresizingMaskIntoConstraints = false
        promocodesValue.trailingAnchor.constraint(equalTo: promocodesDiscountView.trailingAnchor).isActive = true
        promocodesDiscountView.heightAnchor.constraint(equalTo: promocodesValue.heightAnchor).isActive = true
        
        summaryVerticalStackView.addArrangedSubview(promocodesDiscountView)
        
        // payment discount
        paymentDiscountView.translatesAutoresizingMaskIntoConstraints = false
        paymentDiscountView.addSubview(paymentDiscountHeader)
        paymentDiscountHeader.translatesAutoresizingMaskIntoConstraints = false
        paymentDiscountHeader.leadingAnchor.constraint(equalTo: paymentDiscountView.leadingAnchor).isActive = true
        
        paymentDiscountView.addSubview(paymentDiscountValue)
        paymentDiscountValue.translatesAutoresizingMaskIntoConstraints = false
        paymentDiscountValue.trailingAnchor.constraint(equalTo: paymentDiscountView.trailingAnchor).isActive = true
        paymentDiscountValue.topAnchor.constraint(equalTo: paymentDiscountView.topAnchor).isActive = true
        paymentDiscountView.heightAnchor.constraint(equalTo: paymentDiscountValue.heightAnchor).isActive = true
        
        summaryVerticalStackView.addArrangedSubview(paymentDiscountView)
        
        
        // seporator line
        contentView.addSubview(seporatorLine)
        seporatorLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seporatorLine.topAnchor.constraint(equalTo: summaryVerticalStackView.bottomAnchor, constant: 16),
            seporatorLine.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            seporatorLine.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            seporatorLine.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // Summ
        
        contentView.addSubview(summView)
        summView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summView.topAnchor.constraint(equalTo: seporatorLine.bottomAnchor, constant: 16),
            summView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            summView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32)
        ])
        summView.addSubview(summHeader)
        summHeader.translatesAutoresizingMaskIntoConstraints = false
        summHeader.leadingAnchor.constraint(equalTo: summView.leadingAnchor).isActive = true
        
        
        summView.addSubview(summValue)
        summValue.translatesAutoresizingMaskIntoConstraints = false
        
        summValue.trailingAnchor.constraint(equalTo: summView.trailingAnchor).isActive = true
        summView.heightAnchor.constraint(equalTo: summValue.heightAnchor).isActive = true
        
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: summView.bottomAnchor, constant: 16),
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            button.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        contentView.addSubview(oferteLabel)
        oferteLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            oferteLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
            oferteLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            oferteLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            oferteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
