//
//  ButtonCell.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 20.10.2024.
//

import UIKit

class ButtonCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.Button? {
        didSet {
            updateUI()
        }
    }
    
    var bgColor: UIColor?
    
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)

        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside])
        button.layer.cornerRadius = 12
        return button
    }()
    
    @objc func buttonPressed() {
        UIView.animate(withDuration: 0.3) {
            if let alphaValue = self.bgColor?.alpha() {
                if (alphaValue >= 0.5) {
                    self.button.backgroundColor = self.button.backgroundColor?.adjustAlpha(by: -0.5)
                }
                else {
                    self.button.backgroundColor = self.button.backgroundColor?.adjustAlpha(by: 0.5)
                }
            }
            
        }
    }
    
    @objc func buttonReleased() {
        UIView.animate(withDuration: 0.3) {
            if let color = self.bgColor {
                self.button.backgroundColor = color
            }
        }
    }
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private func updateUI() {
        guard let viewModel else {
            return
        }
        
        if let promocodeImage = viewModel.image {
            image.image = promocodeImage
        }
        
        if let buttonTitle = viewModel.title {
            if let titleHexColor = viewModel.titleHexColor {
                self.title.textColor = UIColor(hexString: titleHexColor)
            }
            title.text = buttonTitle
        }
        
        if let hexColor = viewModel.backgroundHexColor {
            bgColor = UIColor(hexString: hexColor)
            button.backgroundColor = bgColor
        }
    }
    
    private func setupUI() {
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: button.topAnchor, constant: 15).isActive = true
        image.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 75).isActive = true
        image.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -15).isActive = true
        
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: button.topAnchor, constant: 15).isActive = true
        title.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -15).isActive = true
        title.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
