//
//  ReviewViewController.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 03.11.2024.
//

import UIKit

class ReviewViewController: UIViewController {
    private var review: Review
    private let viewModel = ReviewViewModel()
    
    private func showReview(review: Review) {
        viewModel.cellViewModels.removeAll()
        
        self.navigationItem.title = "Напишите отзыв"
        
        viewModel.createTable(review: review)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductView.self, forCellReuseIdentifier: String(describing: ProductView.self))
        tableView.register(TextField.self, forCellReuseIdentifier: String(describing: TextField.self))
        tableView.register(RatingCellView.self, forCellReuseIdentifier: String(describing: RatingCellView.self))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        viewModel.dataUpdated = tableView.reloadData
        showReview(review: testReview)
    }
    
    init(review: Review) {
        self.review = review
        super.init(nibName: nil, bundle: nil)
    }
    
    init() {
        self.review = testReview
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReviewViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModel.cellViewModels[indexPath.row]
        
        switch viewModel.type {
        case .promo(let promo):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PromoCell.self)) as? PromoCell else {
                return UITableViewCell()
            }
            cell.viewModel = promo
            cell.selectionStyle = .none
            return cell
        
        case .info(let info):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleCell.self)) as? TitleCell else {
                return UITableViewCell()
            }
            cell.viewModel = info
            cell.selectionStyle = .none
            return cell
            
        case .result(let result):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultCell.self)) as? ResultCell else {
                return UITableViewCell()
            }
            cell.viewModel = result
            cell.selectionStyle = .none
            return cell
            
        case .button(let button):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ButtonCell.self)) as? ButtonCell else {
                return UITableViewCell()
            }
            
            cell.viewModel = button
            cell.selectionStyle = .none
            return cell
        case .input(let text):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PromoTextFieldCell.self)) as? PromoTextFieldCell else {
                return UITableViewCell()
            }
            
            cell.viewModel = text
            cell.selectionStyle = .none
            return cell
        case .product(let product):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductView.self)) as? ProductView else {
                return UITableViewCell()
            }
            
            cell.viewModel = product
            cell.selectionStyle = .none
            return cell
        case .textField(let textField):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextField.self)) as? TextField else {
                return UITableViewCell()
            }
            
            cell.viewModel = textField
            cell.selectionStyle = .none
            return cell
        case .rating(let rating):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RatingCellView.self)) as? RatingCellView else {
                return UITableViewCell()
            }
            
            cell.viewModel = rating
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    
        
    }
    
}
