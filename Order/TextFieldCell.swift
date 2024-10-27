//
//  TextFieldCell.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 28.10.2024.
//


import UIKit

class TextFieldCell: UITableViewCell {    
    private func clearTextField() {
        
    }
    
    private func showWarning() {
        inputView?.layer.borderColor = UIColor(hexString: "#F42D2D").cgColor
        warningLabel.isHidden = false
    }
    
    var viewModel: TableViewModel.ViewModelType.Text? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onTap), for: [.touchDown, .touchDragEnter])
        button.addTarget(self, action: #selector(touchCancelled), for: [.touchUpInside, .touchCancel, .touchDragExit])
        return button
    }()
            
    @objc private func onTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.clearButton.alpha = 0.75
        })
        clearTextField()
    }

    @objc private func touchCancelled() {
        UIView.animate(withDuration: 0.1, animations: {
            self.clearButton.alpha = 1
        })
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "К сожалению, данного промокода не существует"
        label.textColor = UIColor(hexString: "#F42D2D")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var textInputView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var hintLabel: UILabel = {
        let hint = UILabel()
        hint.text = "Введите код"
        hint.textColor = UIColor(hexString: "#7A7A7A")
        return hint
    }()
    
    private func updateUI() {
        guard let viewModel else {
            return
        }
        
        textField.text = viewModel.text
        if let imageName = viewModel.imageName {
            clearButton.setImage(UIImage(named: imageName), for: .normal)
        }
        
        if viewModel.isWarning {
            showWarning()
        }
        
        
    }
    
    private func setupUI() {
        // vertical stack view constraints
        contentView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        // textInputView constraints
        verticalStackView.addArrangedSubview(textInputView)
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textInputView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            textInputView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            textInputView.topAnchor.constraint(equalTo: verticalStackView.topAnchor)
        ])
        
        // hintLabel constraints
        textInputView.addSubview(hintLabel)
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hintLabel.topAnchor.constraint(equalTo: textInputView.topAnchor, constant: 8),
            hintLabel.leadingAnchor.constraint(equalTo: textInputView.leadingAnchor, constant: 12),
            //hintLabel.trailingAnchor.constraint(equalTo: clearButton.trailingAnchor)
        ])
        
        // clearButton constraints
        textInputView.addSubview(clearButton)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: textInputView.topAnchor, constant: 8),
            clearButton.bottomAnchor.constraint(equalTo: textInputView.bottomAnchor, constant: -8),
            clearButton.heightAnchor.constraint(equalToConstant: 36),
            clearButton.widthAnchor.constraint(equalToConstant: 36),
            clearButton.trailingAnchor.constraint(equalTo: textInputView.trailingAnchor, constant: -4)
            
        ])
        
        // textField constraints
        textInputView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: hintLabel.bottomAnchor),
            textField.bottomAnchor.constraint(equalTo: textInputView.bottomAnchor, constant: -8),
            textField.leadingAnchor.constraint(equalTo: textInputView.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: clearButton.leadingAnchor)
        ])
        
        verticalStackView.addArrangedSubview(warningLabel)
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            warningLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
        ])
        warningLabel.isHidden = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

