//
//  ButtonCell.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 20.10.2024.
//

import UIKit

class ButtonCell: UITableViewCell {
    var onTapAction: (() -> Void)?
    
    var viewModel: TableViewModel.ViewModelType.Button? {
        didSet {
            updateUI()
        }
    }
    
    var bgColor: UIColor?
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(onTap), for: [.touchDown, .touchDragEnter])
        button.addTarget(self, action: #selector(touchCancelled), for: [.touchUpInside, .touchCancel, .touchDragExit])
        return button
    }()
            
    @objc private func onTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.button.alpha = 0.75
        })
        onTapAction?()
    }

    @objc private func touchCancelled() {
        UIView.animate(withDuration: 0.1, animations: {
            self.button.alpha = 1
        })
    }
    
    
    
    private func updateUI() {
        guard let viewModel else {
            return
        }
            
        var config = UIButton.Configuration.filled()
        
        if let imageName = viewModel.imageName {
            config.image = UIImage(named: imageName)
        }
        
        if let buttonTitle = viewModel.title {
            if let titleHexColor = viewModel.titleHexColor {
                config.baseForegroundColor = UIColor(hexString: titleHexColor)
            }
            config.title = buttonTitle
        }
        
        if let hexColor = viewModel.backgroundHexColor {
            bgColor = UIColor(hexString: hexColor)
            config.background.backgroundColor = bgColor
        }
       
        button.tintColor = .gray
        config.imagePadding = 10
        config.imagePlacement = .leading
        config.background.cornerRadius = 12
        button.configuration = config
        button.isSymbolAnimationEnabled = true
        
        onTapAction = viewModel.action
    }
    
    private func setupUI() {
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
