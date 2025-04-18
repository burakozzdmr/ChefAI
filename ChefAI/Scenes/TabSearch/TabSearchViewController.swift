//
//  TabSearchViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 17.04.2025.
//

import UIKit
import SnapKit

class TabSearchViewController: UIViewController {

    // MARK: - Properties
    
    private let searchLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "Ara"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .black)
        return label
    }()
    
    private let mostSearchMealsLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "En Çok Arananlar"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .black)
        return label
    }()
    
    private lazy var mostSearchCollectionView: UICollectionView = {
        let screenWidth = UIScreen.main.bounds.width
        let padding: CGFloat = 16 * 3
        let itemWidth = (screenWidth - padding) / 2

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: itemWidth, height: 200)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .customBackgroundColor2
        
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        return collectionView
    }()
    
    private let searchView: SearchBarView = .init()
    private let viewModel: TabSearchViewModel
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Inits
    
    init(viewModel: TabSearchViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension TabSearchViewController {
    func addViews() {
        view.addSubviews(
            searchLabel,
            searchView,
            mostSearchMealsLabel,
            mostSearchCollectionView
        )
    }
    
    func configureConstraints() {
        searchLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.leading.equalToSuperview().offset(16)
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(searchLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        mostSearchMealsLabel.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mostSearchCollectionView.snp.makeConstraints {
            $0.top.equalTo(mostSearchMealsLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        view.backgroundColor = .customBackgroundColor2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchTapped))
        searchView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func searchTapped() {
        print("Search bar tapped")
    }
}

// MARK: - UICollectionViewDataSource

extension TabSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.mostSearchMealList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        cell.configure(cell: viewModel.mostSearchMealList[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TabSearchViewController: UICollectionViewDelegate {
    
}

// MARK: - TabSearchViewModelProtocol

extension TabSearchViewController: TabSearchViewModelProtocol {
    func didUpdateData() {
        print("didUpdateData executed")
        mostSearchCollectionView.reloadData()
    }
}
