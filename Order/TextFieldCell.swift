//
//  TextFieldCell.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 28.10.2024.
//


import UIKit

class TextFieldCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.Text? {
        didSet {
            updateUI()
        }
    }
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "К сожалению, данного промокода не существует"
        label.textColor = UIColor(hexString: "#F42D2D")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var textInputView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private func updateUI() {
        guard let viewModel else {
            return
        }
        
        
    }
    
    private func setupUI() {
        // vertical stack view constraints
        contentView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.rightAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -16),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        
        verticalStackView.addArrangedSubview(textInputView)
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textInputView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            textInputView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            textInputView.topAnchor.constraint(equalTo: verticalStackView.topAnchor)
        ])
        
        verticalStackView.addArrangedSubview(warningLabel)
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            warningLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
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

