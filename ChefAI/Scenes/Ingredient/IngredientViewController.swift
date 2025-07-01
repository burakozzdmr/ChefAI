//
//  IngredientViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 29.06.2025.
//

import UIKit

protocol IngredientControllerOutputProtocol: AnyObject {
    func didUpdateData()
}

class IngredientViewController: UIViewController {

    // MARK: - Properties
    
    private let ingredientLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "Ingredients"
        label.textColor = .white
        return label
    }()
    
    private lazy var ingredientTableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        tableView.register(SelectedIngredientCell.self, forCellReuseIdentifier: SelectedIngredientCell.identifier)
        return tableView
    }()
    
    private let viewModel: IngredientViewModel
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    // MARK: - Inits
    
    init(viewModel: IngredientViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.outputDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension IngredientViewController {
    func configureView() {
        addViews()
        configureConstraints()
    }
    
    func addViews() {
        view.addSubviews(
            ingredientLabel,
            ingredientTableView
        )
    }
    
    func configureConstraints() {
        ingredientLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.leading.equalToSuperview().offset(16)
        }
        
        ingredientTableView.snp.makeConstraints {
            $0.top.equalTo(ingredientLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension IngredientViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.identifier, for: indexPath) as! SelectedIngredientCell
        cell.configure(with: viewModel.ingredientList[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension IngredientViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") {
            _,
            _,
            _ in
            AlertManager.shared.presentAlert(
                with: "UYARI",
                and: "Seçilen malzemeyi silmek mi istiyorsun?",
                buttons: [
                    UIAlertAction(title: "Evet", style: .default, handler: { _ in
                        self.viewModel.deleteIngredients(for: self.viewModel.ingredientList[indexPath.row].ingredientID)
                    }),
                    UIAlertAction(title: "Hayır", style: .destructive)
                ],
                from: self
            )
        }
        deleteAction.image = .init(systemName: "trash.fill")
        deleteAction.backgroundColor = .systemRed
        return .init(actions: [deleteAction])
    }
}

// MARK: - IngredientControllerOutputProtocol

extension IngredientViewController: IngredientControllerOutputProtocol {
    func didUpdateData() {
        DispatchQueue.main.async {
            UIView.transition(with: self.ingredientTableView, duration: 0.5, options: .transitionCrossDissolve) {
                self.ingredientTableView.reloadData()
            }
        }
    }
}
