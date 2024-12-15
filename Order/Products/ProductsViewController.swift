//
//  ProductsViewController.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 31.10.2024.
//

import UIKit

class ProductsViewController: UIViewController {
    private let viewModel = ProductsViewModel()
    
    private var products: [Product] = testProducts
    
    private func showReviewController(product: Product) {
        var review = Review(product: product)
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.navigationItem.backButtonTitle = ""
            self?.navigationController?.pushViewController(ReviewViewController(review: review), animated: true)
        }
    }
    
    private func showProducts(products: [Product]) {
        viewModel.createTable(products: testProducts)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCellView.self, forCellReuseIdentifier: String(describing: ProductCellView.self))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Напишите отзыв"
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        viewModel.dataUpdated = tableView.reloadData
        showProducts(products: testProducts)
    }
}

extension ProductsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCellView.self)) as? ProductCellView else {
                return UITableViewCell()
            }
            
            cell.viewModel = product
            return cell
            
        default:
            return UITableViewCell()
        }
    
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showReviewController(product: products[indexPath.row])
    }
}
