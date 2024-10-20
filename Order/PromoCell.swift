//
//  PromoCell.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 20.10.2024.
//

import UIKit

class PromoCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.Promo? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var mainView = UIView()
    
    private lazy var leftCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: -8, y: -8, width: 16, height: 16)
        return view
    }()
    
    
    private lazy var rightCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: -8, y: -8, width: 16, height: 16)
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

        // Обновляем констрейнты в зависимости от наличия cautionLabel
        updateConstraintsForCautionLabel(isCautionVisible: viewModel.caution != nil)
    }

    private func updateConstraintsForCautionLabel(isCautionVisible: Bool) {
        cautionLabel.removeFromSuperview()
        mainView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: 12).isActive = false

        if isCautionVisible {
            contentView.addSubview(cautionLabel)
            cautionLabel.translatesAutoresizingMaskIntoConstraints = false
            cautionLabel.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 8).isActive = true
            cautionLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -12).isActive = true
            cautionLabel.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 20).isActive = true
            
            // Настраиваем mainView, чтобы он был выше cautionLabel
            mainView.bottomAnchor.constraint(equalTo: cautionLabel.topAnchor, constant: -8).isActive = true
        } else {
            // Если cautionLabel скрыт, mainView должен быть привязан к нижней части background
            mainView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -12).isActive = true
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
        leftCircle.layer.cornerRadius = leftCircle.frame.width / 2
        rightCircle.layer.cornerRadius = rightCircle.frame.width / 2
    }
    
    
    private lazy var titleHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        
        return stack
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .infoLight)
        return button
    }()
    
    func setupUI() {
        contentView.addSubview(background)
        // backGround (gray rectangle) constraints
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            background.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            background.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
        
        // mainView constraints
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: background.topAnchor, constant: 12),
            mainView.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 20),
            mainView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20)
        ])
        
        contentView.addSubview(promoLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(switchButton)
        contentView.addSubview(infoButton)

        promoLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.translatesAutoresizingMaskIntoConstraints = false

        // switchButton constraints
        NSLayoutConstraint.activate([
            switchButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            switchButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infoButton.centerYAnchor.constraint(equalTo: percentLabel.centerYAnchor),
            infoButton.leadingAnchor.constraint(equalTo: percentLabel.trailingAnchor, constant: 4)
        ])

        // percentLabel constraints
        NSLayoutConstraint.activate([
            percentLabel.leadingAnchor.constraint(equalTo: promoLabel.trailingAnchor, constant: 4),
            percentLabel.topAnchor.constraint(equalTo: mainView.topAnchor)
        ])

        // promoLabel constraints
        NSLayoutConstraint.activate([
            promoLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            promoLabel.trailingAnchor.constraint(lessThanOrEqualTo: switchButton.leadingAnchor, constant: -80),
            promoLabel.topAnchor.constraint(equalTo: mainView.topAnchor)
        ])

        //promoLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        //percentLabel.setContentHuggingPriority(.required, for: .horizontal)
        //.setContentHuggingPriority(.required, for: .horizontal)
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        
        
        promoLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        promoLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        
        contentView.addSubview(cautionLabel)
        
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
