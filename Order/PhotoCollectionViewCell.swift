//
//  PhotoCollectionViewCell.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 04.11.2024.
//
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var deleteCell: ((PhotoCollectionViewCell) -> Void)?
    
    static let identifier = "PhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✕", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    @objc private func deleteButtonAction() {
        deleteCell?(self)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage, isDeleteable: Bool = false, deleteClousure: ((PhotoCollectionViewCell) -> Void)? = nil) {
        imageView.image = image
        if isDeleteable {
            contentView.addSubview(deleteButton)
            deleteButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                deleteButton.widthAnchor.constraint(equalToConstant: 20),
                deleteButton.heightAnchor.constraint(equalToConstant: 20),
            ])
            
            if let deleteClousure = deleteClousure {
                self.deleteCell = deleteClousure
            }
        }
        else {
            deleteButton.removeFromSuperview()
        }
    }
}
