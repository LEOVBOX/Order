//
//  PromoCell.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 20.10.2024.
//

import UIKit

class PromoCell: UITableViewCell {
    // What to do when buttonSwitch toggled
    var onToggle: ((Bool, String) -> Void)?
    
    var viewModel: TableViewModel.ViewModelType.Promo? {
        didSet {
            if let viewModel = viewModel, let toggleClosure = viewModel.toggle {
                onToggle = toggleClosure
            }
            
            updateUI()
        }
    }
    
    private lazy var mainView = UIView()
    
    private lazy var leftCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    
    private lazy var rightCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#F6F6F6")
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var promoLabel: UILabel = {
        let label = UILabel()
        label.text = "PromoLabel"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto", size: 14)
        label.textColor = UIColor(hexString: "#7A7A7A")
        return label
    }()
    
    private lazy var cautionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto", size: 16)
        label.textColor = UIColor(hexString: "#7A7A7A")
        return label
    }()
    
    private lazy var titleView = UIView()
    
    lazy var switchButton: UISwitch = {
        let button = UISwitch()
        button.isOn = false
        button.addTarget(self, action: #selector(toggle), for: .valueChanged)
        button.onTintColor = UIColor(hexString: "#FF4611")
        return button
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(hexString: "#00B775")
        label.text = "0%"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Roboto", size: 12)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()

    
    @objc func toggle() {
        guard let viewModel else { return }
        viewModel.toggle?(switchButton.isOn, viewModel.id)
    }
    
    private func updateUI() {
        guard let viewModel else { return }

        promoLabel.text = viewModel.title
        switchButton.isOn = viewModel.isActive
        dateLabel.text = viewModel.date
        percentLabel.text = viewModel.percent

        // Обновляем текст и видимость cautionLabel
        if let infoText = viewModel.caution {
            cautionLabel.text = infoText
            cautionLabel.isHidden = false
        } else {
            cautionLabel.isHidden = true
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "infoButton"), for: .normal)
        return button
    }()
    
    
    func setupUI() {
        // background constraints
        contentView.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            background.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            background.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
        
        // stackView constraints
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: background.topAnchor, constant: 12),
            stackView.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: background.rightAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -12)
        ])
        stackView.spacing = 4
        
        // mainView constraints
        stackView.addArrangedSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
        
                

        // switchButton constraints
        mainView.addSubview(switchButton)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switchButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            switchButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
        
        // percentLabel constraints
        mainView.addSubview(percentLabel)
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentLabel.topAnchor.constraint(equalTo: mainView.topAnchor)
        ])
        
        // infoButton constraints
        mainView.addSubview(infoButton)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoButton.centerYAnchor.constraint(equalTo: percentLabel.centerYAnchor),
            infoButton.leadingAnchor.constraint(equalTo: percentLabel.trailingAnchor, constant: 4),
            infoButton.trailingAnchor.constraint(lessThanOrEqualTo: switchButton.leadingAnchor, constant: -4)
        ])

        

        // promoLabel constraints
        mainView.addSubview(promoLabel)
        promoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promoLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            promoLabel.trailingAnchor.constraint(equalTo: percentLabel.leadingAnchor, constant: -8),
            promoLabel.topAnchor.constraint(equalTo: mainView.topAnchor)
        ])

        // priorities
        promoLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        percentLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        infoButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        switchButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        promoLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        // dateLabel constraints
        mainView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        
        promoLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        contentView.addSubview(cautionLabel)
        
        stackView.addArrangedSubview(cautionLabel)
        cautionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cautionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            cautionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            cautionLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
        
        contentView.addSubview(leftCircle)
        leftCircle.translatesAutoresizingMaskIntoConstraints = false
        leftCircle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        leftCircle.heightAnchor.constraint(equalToConstant: 16).isActive = true
        leftCircle.widthAnchor.constraint(equalToConstant: 16).isActive = true
        leftCircle.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        
        contentView.addSubview(rightCircle)
        rightCircle.translatesAutoresizingMaskIntoConstraints = false
        rightCircle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        rightCircle.heightAnchor.constraint(equalToConstant: 16).isActive = true
        rightCircle.widthAnchor.constraint(equalToConstant: 16).isActive = true
        rightCircle.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
    }
}
