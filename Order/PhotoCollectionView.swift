//
//  PhotoCollectionView.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 04.11.2024.
//

import UIKit

class PhotoCollectionView: UITableViewCell {
    
    var viewModel: TableViewModel.ViewModelType.PhotoCollection? {
        didSet {
            updateUI()
        }
    }
    
    private var images: [UIImage] = [] // Массив изображений для коллекции
    
    
    // Создаем collectionView с FlowLayout
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 80, height: 80) // Устанавливаем примерный размер ячеек
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false // Отключаем прокрутку
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Метод для передачи изображений в ячейку
    func configure(with images: [UIImage]) {
        self.images = images
        collectionView.reloadData()
    }
    
    enum CollectionViewConstraints {
        case topAnchor
        case bottomAncor
        case leftAnchor
        case rightAnchor
        case height
        
        var value: CGFloat {
            switch self {
            case .topAnchor:
                return 8
            case .bottomAncor:
                return -8
            case .leftAnchor:
                return 16
            case .rightAnchor:
                return -16
            case .height:
                return 80
            }
        }
    }
    
    func setupUI() {
        contentView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CollectionViewConstraints.topAnchor.value),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CollectionViewConstraints.leftAnchor.value),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CollectionViewConstraints.rightAnchor.value),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: CollectionViewConstraints.bottomAncor.value),
            collectionView.heightAnchor.constraint(equalToConstant: CollectionViewConstraints.height.value)
        ])
    }
    
    func updateUI() {
        guard let viewModel else {return}
        for imageName in viewModel.imageNames {
            if let image = UIImage(named: imageName) {
                self.images.append(image)
            }
        }
    }
}

extension PhotoCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(images.count + 1, 8) // Ограничиваем до 8 элементов (7 фото + кнопка загрузки)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        if indexPath.item < images.count {
            cell.configure(with: images[indexPath.item])
        } else {
            cell.configure(with: UIImage(systemName: "icloud.and.arrow.up")!) // Иконка добавления
        }
        return cell
    }
    
    // Метод для задания размера ячейки в зависимости от ширины экрана
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 4
        let spacing: CGFloat = 8
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacing)
        
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
    
    
}
