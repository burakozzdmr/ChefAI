//
//  FavouriteViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 28.06.2025.
//

import UIKit
import SnapKit

class FavouriteViewController: UIViewController {

    // MARK: - Properties
    
    private let favouriteLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "Favourites"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    
    private lazy var favouritesTableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 140
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.identifier)
        return tableView
    }()
    
    private let viewModel: FavouriteViewModel
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    // MARK: - Inits
    
    init(viewModel: FavouriteViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension FavouriteViewController {
    func configureView() {
        addViews()
        configureConstraints()
    }
    
    func addViews() {
        view.addSubviews(
            favouriteLabel,
            favouritesTableView
        )
    }
    
    func configureConstraints() {
        favouriteLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.leading.equalToSuperview().offset(32)
        }
        
        favouritesTableView.snp.makeConstraints {
            $0.top.equalTo(favouriteLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favouriteMealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.identifier, for: indexPath) as! FavouriteCell
        cell.configure(with: viewModel.favouriteMealList[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(
            MealDetailViewController(
                viewModel: MealDetailViewModel(mealDetailData: viewModel.favouriteMealList[indexPath.row])
            ),
            animated: true
        )
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return .init()
    }
}
