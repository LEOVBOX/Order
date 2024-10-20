//
//  TitleCell.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 20.10.2024.
//

import UIKit

class TitleCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.TitleInfo? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        label.font = UIFont(name:"Roboto", size: 24)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private func updateUI() {
        guard let viewModel else {
            return
        }

        titleLabel.text = viewModel.title
        infoLabel.text = viewModel.info
    }

    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        
        contentView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
}
