//
//  ProductView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 01.11.2024.
//

import UIKit

class ProductCellView: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.Product? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let chevronImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "rightChevronArrow"))
        view.tintColor = .gray
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var productImage: DownloadableImageView = {
        let imageView = DownloadableImageView()
        return imageView
    }()
    
    private lazy var descriptionView: UIView = {
        let view = UIView()
        return view
    }()
    
    private func updateUI() {
        guard let viewModel else { return }
        
        titleLabel.text = viewModel.title
        productImage.loadImage(url: viewModel.imageUrl)
        

        if !viewModel.isListElement {
            chevronImageView.image = .none
            if let size = viewModel.sizeString {
                sizeLabel.text = size
            }
        }
    
    }
    
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#7A7A7A")
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    enum CellConstraints {
        case leftPadding
        case rightPadding
        case topPadding
        case bottomPadding
        case titleLabelLeftPadding
        
        var value: CGFloat {
                switch self {
                case .leftPadding:
                    return 20
                case .rightPadding:
                    return -20
                case .topPadding:
                    return 12
                case .bottomPadding:
                    return -12
                case .titleLabelLeftPadding:
                    return 12
                }
            }
    }
    
    enum ImageConstraints {
        case imageHeight
        case imageWidth
        var value: CGFloat {
            switch self {
            case .imageWidth:
                return 80
            case .imageHeight:
                return 80
            }
        }
    }
    
    enum TitleLabelConstraints {
        case topPadding
        case bottomPadding
        var value: CGFloat {
            switch self {
            case .bottomPadding:
                return -8
            case .topPadding:
                return 8
            }
        }
    }
    
    enum ChevronImageViewConstraints {
        case width
        case height
        var value: CGFloat {
            switch self {
            case .height:
                return 14
            case .width:
                return 8
            }
        }
    }
    
    enum DescriptionViewConstraints {
        case topPadding
        case bottomPadding
        case leftPadding
        var value: CGFloat {
            switch self {
            case .bottomPadding:
                return -8
            case .topPadding:
                return 8
            case .leftPadding:
                return 12
            }
        }
    }

    
    func setupUI() {
        //contentView.backgroundColor = .green
        
        // mainView constraints
        contentView.addSubview(mainView)
        //mainView.backgroundColor = .orange
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CellConstraints.topPadding.value),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: CellConstraints.bottomPadding.value),
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CellConstraints.leftPadding.value),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CellConstraints.rightPadding.value)
        ])
        
        // image constraints
        mainView.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImage.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            productImage.widthAnchor.constraint(equalToConstant: ImageConstraints.imageWidth.value),
            productImage.topAnchor.constraint(equalTo: mainView.topAnchor),
            productImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            productImage.heightAnchor.constraint(equalToConstant: ImageConstraints.imageHeight.value)
        ])
        
        // descriptionView constraints
        mainView.addSubview(descriptionView)
        //descriptionView.backgroundColor = .blue
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: DescriptionViewConstraints.topPadding.value),
            descriptionView.rightAnchor.constraint(equalTo: mainView.rightAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: DescriptionViewConstraints.bottomPadding.value),
            descriptionView.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: DescriptionViewConstraints.leftPadding.value)
        ])
        
        // chevronImageView constraints
        descriptionView.addSubview(chevronImageView)
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chevronImageView.rightAnchor.constraint(equalTo: descriptionView.rightAnchor),
            chevronImageView.centerYAnchor.constraint(equalTo: descriptionView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: ChevronImageViewConstraints.width.value),
            chevronImageView.heightAnchor.constraint(equalToConstant: ChevronImageViewConstraints.height.value)
        ])
        
        // captionView constraints
        descriptionView.addSubview(sizeLabel)
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sizeLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            sizeLabel.rightAnchor.constraint(equalTo: descriptionView.rightAnchor),
            sizeLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor),
            sizeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // titleLabel constraints
        descriptionView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        //titleLabel.backgroundColor = .red
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            titleLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: TitleLabelConstraints.topPadding.value),
            titleLabel.bottomAnchor.constraint(equalTo: sizeLabel.topAnchor),
            titleLabel.rightAnchor.constraint(equalTo: chevronImageView.leftAnchor)
        ])
        
        
        
        
    }
}
