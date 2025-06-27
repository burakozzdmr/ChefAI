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
    
    private lazy var favouritesCollectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = .init()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.minimumLineSpacing = 16
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 140)
        
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
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
            favouritesCollectionView
        )
    }
    
    func configureConstraints() {
        favouriteLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(32)
        }
        
        favouritesCollectionView.snp.makeConstraints {
            $0.top.equalTo(favouriteLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FavouriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favouriteMealList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteCell.identifier, for: indexPath) as! FavouriteCell
        cell.configure(with: viewModel.favouriteMealList[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension FavouriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
