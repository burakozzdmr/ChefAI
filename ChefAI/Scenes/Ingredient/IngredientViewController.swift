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
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        return label
    }()
    
    private lazy var ingredientCollectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = .init()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 32) / 2, height: 80)
        
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .customBackgroundColor2
        collectionView.dataSource = self
        collectionView.register(SelectedIngredientCell.self, forCellWithReuseIdentifier: SelectedIngredientCell.identifier)
        return collectionView
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
        
        view.backgroundColor = .customBackgroundColor2
    }
    
    func addViews() {
        view.addSubviews(
            ingredientLabel,
            ingredientCollectionView
        )
    }
    
    func configureConstraints() {
        ingredientLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.leading.equalToSuperview().offset(16)
        }
        
        ingredientCollectionView.snp.makeConstraints {
            $0.top.equalTo(ingredientLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension IngredientViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.ingredientList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedIngredientCell.identifier, for: indexPath) as! SelectedIngredientCell
        cell.configure(with: viewModel.ingredientList[indexPath.row])
        return cell
    }
}

// MARK: - IngredientControllerOutputProtocol

extension IngredientViewController: IngredientControllerOutputProtocol {
    func didUpdateData() {
        DispatchQueue.main.async {
            UIView.transition(with: self.ingredientCollectionView, duration: 0.3, options: .transitionCrossDissolve) {
                self.ingredientCollectionView.reloadData()
            }
        }
    }
}
