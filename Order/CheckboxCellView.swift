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
    
    //private lazy var checkBoxView: UI
    
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
    
    private func setupUI() {
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MainViewConstraints.topAnchor.value),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: MainViewConstraints.bottomAnchor.value),
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: MainViewConstraints.leftAnchor.value),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: MainViewConstraints.rightAnchor.value)
        ])
        
        
    }
    
    private func updateUI() {
        
    }
    
}
