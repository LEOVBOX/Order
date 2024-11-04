//
//  CheckboxCellView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 03.11.2024.
//

import UIKit

class CheckboxCellView: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.Checkbox? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var isChecked: Bool = false
    
    private lazy var checkBoxView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.borderColor = UIColor(hexString: "#7A7A7A").cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(checked), for: .touchUpInside)
        button.setImage(UIImage(named: "true"), for: [.selected, .highlighted])
        return button
    }()
    
    private lazy var labelView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    @objc private func checked() {
        isChecked = !isChecked
        if (isChecked) {
            self.checkBoxView.layer.borderColor = .none
            self.checkBoxView.backgroundColor = UIColor(hexString: "#FF4611")
        }
        else {
            self.checkBoxView.layer.borderColor = UIColor(hexString: "#7A7A7A").cgColor
            self.checkBoxView.backgroundColor = .none
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    enum MainViewConstraints {
        case topAnchor
        case bottomAnchor
        case leftAnchor
        case rightAnchor
        
        var value: CGFloat {
            switch self {
            case .topAnchor:
                return 8
            case .bottomAnchor:
                return -8
            case .leftAnchor:
                return 16
            case .rightAnchor:
                return -16
            }
        }
    }
    
    enum CheckboxConstraints {
        case topAnchor
        case bottomAnchor
        case leftAnchor
        case height
        case width
        
        var value: CGFloat {
            switch self {
            case .topAnchor:
                return 2
            case .bottomAnchor:
                return -2
            case .leftAnchor:
                return 12
            case .height:
                return 20
            case .width:
                return 20
            }
        }
    }
        
    enum LabelViewConstraints {
        case topAnchor
        case bottomAnchor
        case leftAnchor
        case rightAnchor
        
        var value: CGFloat {
            switch self {
            case .topAnchor:
                return 2
            case .bottomAnchor:
                return -2
            case .leftAnchor:
                return 8
            case .rightAnchor:
                return -12
            }
        }
    }
        
    private func setupUI() {
        // mainView constraints
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MainViewConstraints.topAnchor.value),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: MainViewConstraints.bottomAnchor.value),
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: MainViewConstraints.leftAnchor.value),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: MainViewConstraints.rightAnchor.value)
        ])
        
        // checkBoxView constraints
        contentView.addSubview(checkBoxView)
        checkBoxView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkBoxView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: CheckboxConstraints.topAnchor.value),
            checkBoxView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: CheckboxConstraints.bottomAnchor.value),
            checkBoxView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: CheckboxConstraints.leftAnchor.value),
            checkBoxView.heightAnchor.constraint(equalToConstant: CheckboxConstraints.height.value),
            checkBoxView.widthAnchor.constraint(equalToConstant: CheckboxConstraints.width.value)
        ])
        
        contentView.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: LabelViewConstraints.topAnchor.value),
            labelView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: LabelViewConstraints.bottomAnchor.value),
            labelView.leftAnchor.constraint(equalTo: checkBoxView.rightAnchor, constant: LabelViewConstraints.leftAnchor.value),
            labelView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: LabelViewConstraints.rightAnchor.value),
            
        ])
        
        
    }
    
    private func updateUI() {
        guard let viewModel else { return }
        
        if let label = viewModel.label {
            labelView.text = label
        }
        
    }
        
}

