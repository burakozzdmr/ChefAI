//
//  SearchViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 17.04.2025.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.isActive = true
        searchController.searchBar.tintColor = .white
        return searchController
    }()
    
    private let latestSearchLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "Latest Search"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    
    private lazy var searchResultTableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.backgroundColor = .customBackgroundColor2
        tableView.separatorStyle = .none
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        return tableView
    }()
    
    private let viewModel: SearchViewModel
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Inits
    
    init(viewModel: SearchViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension SearchViewController {
    func addViews() {
        view.addSubviews(
            latestSearchLabel,
            searchResultTableView
        )
    }
    
    func configureConstraints() {
        latestSearchLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.trailing.equalToSuperview().offset(32)
        }
        
        searchResultTableView.snp.makeConstraints {
            $0.top.equalTo(latestSearchLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.searchTextField.tintColor = .white
        searchController.searchBar.searchTextField.backgroundColor = .darkGray
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        configureNavigationBar()
        
        view.backgroundColor = .customBackgroundColor2
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchMealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        cell.configure(with: viewModel.searchMealList[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // present meal detail screen
    }
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != "" {
            viewModel.searchMeal(searchText: searchController.searchBar.text ?? "")
        } else {
            // fetchLatestSelectedMeals() call
        }
    }
}

// MARK: - UISearchControllerDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: false)
    }
}

// MARK: - SearchViewModelProtocol

extension SearchViewController: SearchViewModelProtocol {
    func didUpdateData() {
        UIView.transition(with: searchResultTableView, duration: 0.5, options: .transitionCrossDissolve) {
            DispatchQueue.main.async {
                self.searchResultTableView.reloadData()
            }
        }
    }
}
