//
//  ViewController.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 17.10.2024.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel = ViewModel()


    private func showOrder(order: Order) {
        // Очищаем текущие данные
        viewModel.cellViewModels.removeAll()
        
        self.navigationItem.title = order.screenTitle

        viewModel.createTable(order: order)
    }
    
    private func showPromocodeViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.navigationController?.pushViewController(PromocodeViewController(), animated: false)
        }
    }
    
    private func showPromocodesCountAlert() {
        let alertController = UIAlertController(title: title, message: "Для каждого продукта можно прменить только 1 промокод", preferredStyle: .alert)
            
            // Добавляем кнопку "OK"
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            // Показываем предупреждение
            present(alertController, animated: true, completion: nil)
    }
    
    private lazy var seporatorView: UIView = {
        let seporator = UIView()
        seporator.backgroundColor = UIColor(hexString: "#F6F6F6")
        return seporator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hexString: "#F6F6F6")
        tableView.register(TitleCell.self, forCellReuseIdentifier: String(describing: TitleCell.self))
        tableView.register(PromoCell.self, forCellReuseIdentifier: String(describing: PromoCell.self))
        tableView.register(ButtonCell.self, forCellReuseIdentifier: String(describing: ButtonCell.self))
        tableView.register(ResultCell.self, forCellReuseIdentifier: String(describing: ResultCell.self))
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
        viewModel.showPromcodesCountAlert = self.showPromocodesCountAlert
        viewModel.showPromocodesViewController = self.showPromocodeViewController
        showOrder(order: testOrder)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
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
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


