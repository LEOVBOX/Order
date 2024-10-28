//
//  TextFieldCell.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 28.10.2024.
//


import UIKit

class TextFieldCell: UITableViewCell {    
    var buttonTapAction: ((String) -> Bool)?
    
    private func clearTextField() {
        textField.text = ""
        textInputView.layer.borderColor = UIColor.black.cgColor
    }
    
    
    
    var viewModel: TableViewModel.ViewModelType.Input? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onClearTap), for: [.touchDown, .touchDragEnter])
        button.addTarget(self, action: #selector(touchCancelled), for: [.touchUpInside, .touchCancel, .touchDragExit])
        return button
    }()
            
    @objc private func onClearTap() {
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
    
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Применить", for: .normal)
        button.backgroundColor = UIColor(hexString: "#FF4611")
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(onButtonTap), for: [.touchDown, .touchDragEnter])
        return button
    }()
            
    @objc private func onButtonTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.button.alpha = 0.75
        },
                       completion: { _ in
                           UIView.animate(withDuration: 0.1) {
                               self.button.alpha = 1
                           }
                       })
        
        if let applied = buttonTapAction?(textField.text ?? "") {
            if !applied {
                showWarning()
            }
        }
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
    
    private func showWarning() {
        textInputView.layer.borderColor = UIColor(hexString: "#F42D2D").cgColor
        warningLabel.isHidden = false
    }
    
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
        buttonTapAction = viewModel.action
        
    }
    
    
    
    private func setupUI() {
        // button constraints
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            button.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        // vertical stack view constraints
        contentView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            verticalStackView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8)
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

