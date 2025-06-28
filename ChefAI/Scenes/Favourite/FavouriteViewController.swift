//
//  FavouriteViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 28.06.2025.
//

import UIKit
import SnapKit

protocol FavouriteControllerProtocol: AnyObject {
    func didUpdateData()
}

class FavouriteViewController: UIViewController {

    // MARK: - Properties
    
    private let favouriteLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "Favourites"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    
    private lazy var favouritesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 156)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavouriteCell.self, forCellWithReuseIdentifier: FavouriteCell.identifier)
        collectionView.backgroundColor = .customBackgroundColor2
        return collectionView
    }()
    
    private let viewModel: FavouriteViewModel
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchFavouriteMeals()
    }
    
    // MARK: - Inits
    
    init(viewModel: FavouriteViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.controllerDelegate = self
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
        
        view.backgroundColor = .customBackgroundColor2
    }
    
    func addViews() {
        view.addSubviews(
            favouriteLabel,
            favouritesCollectionView
        )
    }
    
    func configureConstraints() {
        favouriteLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.leading.equalToSuperview().offset(16)
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
        self.navigationController?.pushViewController(
            MealDetailViewController(
                viewModel: MealDetailViewModel(mealDetailData: viewModel.favouriteMealList[indexPath.row])
            ),
            animated: true
        )
    }
}

// MARK: FavouriteControllerProtocol

extension FavouriteViewController: FavouriteControllerProtocol {
    func didUpdateData() {
        DispatchQueue.main.async {
            UIView.transition(with: self.favouritesCollectionView, duration: 0.5, options: .transitionCrossDissolve) {
                self.favouritesCollectionView.reloadData()
            }
        }
    }
}
