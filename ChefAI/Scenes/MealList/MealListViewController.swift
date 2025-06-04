//
//  MealListViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 13.03.2025.
//

import UIKit
import SnapKit

class MealListViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var backButton: UIButton = {
        let button: UIButton = .init()
        let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .heavy)
        button.setImage(UIImage(systemName: "chevron.left", withConfiguration: configuration), for: .normal)
        button.tintColor = .customButton
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var mealsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 156)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.identifier)
        collectionView.backgroundColor = .customBackgroundColor2
        return collectionView
    }()
    
    private let viewModel: MealListViewModel
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Inits
    
    init(viewModel: MealListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension MealListViewController {
    func addViews() {
        view.addSubviews(
            mealsCollectionView,
            backButton
        )
    }
    
    func configureConstraints() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(48)
        }
        
        mealsCollectionView.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        view.backgroundColor = .customBackgroundColor2
        navigationItem.title = viewModel.categoryTitle
    }
}

// MARK: - Objective-C Methods

@objc private extension MealListViewController {
    func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension MealListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.mealListByCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        cell.configure(with: viewModel.mealListByCategory[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MealListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = MealDetailViewController(
            viewModel: MealDetailViewModel(
                mealDetailData: viewModel.mealListByCategory[indexPath.row]
            )
        )
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - MealListViewModelProtocol

extension MealListViewController: MealListViewModelProtocol {
    func didUpdateData() {
        print("didUpdateData executed")
        DispatchQueue.main.async {
            self.mealsCollectionView.reloadData()
        }
    }
}
