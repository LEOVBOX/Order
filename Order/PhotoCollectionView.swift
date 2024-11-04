import UIKit

class PhotoCollectionView: UITableViewCell {
    
    var viewModel: TableViewModel.ViewModelType.PhotoCollection? {
            didSet {
                updateUI()
            }
        }
        
        private var allImages: [UIImage] = []         // Полный массив изображений
        private var displayedImages: [UIImage] = []   // Массив отображаемых изображений
        private var isAddIconShown = true             // Флаг для контроля показа иконки добавления
        
        func requiredHeight() -> CGFloat {
            let numberOfItemsPerRow: CGFloat = 4
            let spacing: CGFloat = 8
            let itemHeight = (UIScreen.main.bounds.width - (numberOfItemsPerRow + 1) * spacing) / numberOfItemsPerRow
            let rows = ceil(CGFloat(displayedImages.count + 1) / numberOfItemsPerRow) // +1 для кнопки добавления
            return rows * itemHeight + (rows + 1) * spacing
        }
            
        private lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
            layout.scrollDirection = .vertical
            
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
        
        // Метод для передачи всех изображений в ячейку
        func configure(with images: [UIImage]) {
            self.allImages = images
            displayedImages = [] // Начинаем с пустого массива отображаемых изображений
            collectionView.reloadData()
        }
        
        func setupUI() {
            contentView.addSubview(collectionView)
            
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
        }
    
    
    func updateUI() {
        guard let viewModel else { return }
        for imageName in viewModel.imageNames {
            if let image = UIImage(named: imageName) {
                self.allImages.append(image)
            }
        }
    }
}

extension PhotoCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedImages.count + (isAddIconShown ? 1 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        if indexPath.item < displayedImages.count {
            cell.configure(with: displayedImages[indexPath.item])
        } else {
            cell.configure(with: UIImage(systemName: "icloud.and.arrow.up")!) // Иконка добавления
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == displayedImages.count && isAddIconShown { // Если нажали на иконку добавления
            addNextImage()
        }
    }
    
    func addNextImage() {
        guard displayedImages.count < allImages.count else { return }
        displayedImages.append(allImages[displayedImages.count]) // Добавляем следующее изображение
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 4
        let spacing: CGFloat = 8
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacing)
        
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
}

