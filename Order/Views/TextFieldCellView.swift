//
//  TextField.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 03.11.2024.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.TextField? {
        didSet {
            updateUI()
        }
    }
    
    public lazy var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    
    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#F6F6F6")
        view.layer.cornerRadius = 12
        return view
    }()

    
    enum BackgroundConstraints {
        case topPadding
        case bottomPadding
        case leftPadding
        case rightPadding
        var value: CGFloat {
            switch self {
            case .bottomPadding:
                return -8
            case .topPadding:
                return 8
            case .leftPadding:
                return 16
            case .rightPadding:
                return -16
            }
        }
    }
    
    enum TextFieldConstraints {
        case topPadding
        case bottomPadding
        case leftPadding
        case rightPadding
        var value: CGFloat {
            switch self {
            case .bottomPadding:
                return -16
            case .topPadding:
                return 16
            case .leftPadding:
                return 12
            case .rightPadding:
                return -12
            }
        }
    }
    
    private func setupUI() {
        contentView.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: BackgroundConstraints.topPadding.value),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: BackgroundConstraints.bottomPadding.value),
            background.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: BackgroundConstraints.leftPadding.value),
            background.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: BackgroundConstraints.rightPadding.value)
            
        ])
        
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: background.topAnchor, constant: TextFieldConstraints.topPadding.value),
            textField.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: TextFieldConstraints.bottomPadding.value),
            textField.leftAnchor.constraint(equalTo: background.leftAnchor, constant: TextFieldConstraints.leftPadding.value),
            textField.rightAnchor.constraint(equalTo: background.rightAnchor, constant: TextFieldConstraints.rightPadding.value)
            
        ])
    }
    
    private func updateUI() {
        guard let viewModel else { return }
        
        if let hint = viewModel.hint {
            textField.placeholder = hint
        }
        
        if let text = viewModel.text {
            textField.text = text
        }
        
        if let returnKeyType = viewModel.returnKeyType {
            switch returnKeyType {
            case .done:
                textField.returnKeyType = .done
            case .next:
                textField.returnKeyType = .next
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
}
