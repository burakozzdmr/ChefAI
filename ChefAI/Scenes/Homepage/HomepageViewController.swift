//
//  HomepageViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import UIKit
import SnapKit

// MARK: - HomepageViewController

class HomepageViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Ara..."
        return searchController
    }()
    
    private lazy var sectionsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
        
        let collectionView = UICollectionView()
        collectionView.dataSource = self
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColor = .customBackgroundColor2
        collectionView.register(MealsCell.self, forCellWithReuseIdentifier: MealsCell.identifier)
        return collectionView
    }()
    
    private lazy var askToChefButton: UIButton = {
        let button = UIButton()
        button.setTitle("Şefe Sor", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.tintColor = .white
        button.backgroundColor = .customButton
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(askChefTapped), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: HomepageViewModel
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Inits
    
    init(viewModel: HomepageViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension HomepageViewController {
    func addViews() {
        view.addSubview(sectionsCollectionView)
        view.addSubview(askToChefButton)
        navigationItem.searchController = searchController
    }
    
    func configureConstraints() {
        sectionsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        askToChefButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(160)
            make.height.equalTo(48)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        view.backgroundColor = .customBackgroundColor2
    }
}

// MARK: - Objective-C Methods

private extension HomepageViewController {
    @objc func askChefTapped() {
        
    }
}

// MARK: - UISearchBarDelegate

extension HomepageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

// MARK: - UICollectionViewDataSource

extension HomepageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
