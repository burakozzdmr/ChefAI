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
    
    private lazy var mealsCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            self?.createSectionLayout(cellSectionIndex: .init(for: sectionIndex))
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(MealCell.self, forCellWithReuseIdentifier: MealCell.identifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.register(DailyMealCell.self, forCellWithReuseIdentifier: DailyMealCell.identifier)
        collectionView.register(IngredientCell.self, forCellWithReuseIdentifier: IngredientCell.identifier)
        collectionView.register(
                                SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.identifier
        )
        return collectionView
    }()
    
    private lazy var askToChefButton: UIButton = {
        let button = UIButton()
        button.setTitle("Şefe Sor", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.tintColor = .white
        button.backgroundColor = .customButton
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(askChefTapped), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: HomepageViewModel
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.delegate = self
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
        view.addSubview(mealsCollectionView)
        view.addSubview(askToChefButton)
    }
    
    func configureConstraints() {
        mealsCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        askToChefButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(128)
            make.height.equalTo(48)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        view.backgroundColor = .customBackgroundColor2
        navigationController?.navigationBar.isHidden = true
    }
    
    func createSectionLayout(cellSectionIndex: CellSizeType) -> NSCollectionLayoutSection {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        switch cellSectionIndex {
        case .large:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.4)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = [header]
            return section
            
        case .medium:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .fractionalHeight(0.3)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = [header]
            return section
        }
    }
}

// MARK: - Objective-C Methods

private extension HomepageViewController {
    @objc func askChefTapped() {
        
    }
}

// MARK: - UICollectionViewDataSource

extension HomepageViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let contentType: SectionContentType = .init(for: section)
        switch contentType {
        case .dailyMeal:
            return viewModel.dailyMealList.count
            
        case .ingredientList:
            return viewModel.ingredientList.count
            
        case .categoryList:
            return viewModel.categoryList.count
            
        case .mealList:
            return viewModel.mealList.count
            
        case .breakfast:
            return viewModel.breakfastList.count
            
        case .starter:
            return viewModel.starterList.count
            
        case .meat:
            return viewModel.meatList.count
            
        case .seafood:
            return viewModel.seafoodList.count
            
        case .vegetarian:
            return viewModel.vegetarianList.count
            
        case .pasta:
            return viewModel.pastaList.count
            
        case .dessert:
            return viewModel.dessertList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let contentType: SectionContentType = .init(for: indexPath.section)
        
        switch contentType {
        case .dailyMeal:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyMealCell.identifier, for: indexPath) as! DailyMealCell
            cell.configure(with: viewModel.dailyMealList[indexPath.row])
            return cell
            
        case .ingredientList:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCell.identifier, for: indexPath) as! IngredientCell
            cell.configure(with: viewModel.ingredientList[indexPath.row])
            return cell
            
        case .categoryList:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            cell.configure(with: viewModel.categoryList[indexPath.row])
            return cell
            
        case .mealList:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.identifier, for: indexPath) as! MealCell
            cell.configure(with: viewModel.mealList[indexPath.row])
            return cell
            
        case .breakfast:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.identifier, for: indexPath) as! MealCell
            cell.configure(with: viewModel.breakfastList[indexPath.row])
            return cell
            
        case .starter:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.identifier, for: indexPath) as! MealCell
            cell.configure(with: viewModel.starterList[indexPath.row])
            return cell
            
        case .meat:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.identifier, for: indexPath) as! MealCell
            cell.configure(with: viewModel.meatList[indexPath.row])
            return cell
            
        case .seafood:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.identifier, for: indexPath) as! MealCell
            cell.configure(with: viewModel.seafoodList[indexPath.row])
            return cell
            
        case .vegetarian:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.identifier, for: indexPath) as! MealCell
            cell.configure(with: viewModel.vegetarianList[indexPath.row])
            return cell
            
        case .pasta:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.identifier, for: indexPath) as! MealCell
            cell.configure(with: viewModel.pastaList[indexPath.row])
            return cell
            
        case .dessert:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.identifier, for: indexPath) as! MealCell
            cell.configure(with: viewModel.dessertList[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.identifier,
                for: indexPath
            ) as! SectionHeaderView
            
            header.configure(with: viewModel.sectionList[indexPath.section])
            return header
        }
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegate

extension HomepageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType: SectionContentType = .init(for: indexPath.section)
        
        switch sectionType {
        case .dailyMeal:
            self.navigationController?.pushViewController(
                MealDetailViewController(
                    viewModel: MealDetailViewModel(mealDetailData: viewModel.dailyMealList[indexPath.row])
                ),
                animated: true
            )
        case .ingredientList:
            self.navigationController?.pushViewController(
                IngredientViewController(
                    viewModel: IngredientViewModel(ingredientData: viewModel.ingredientList[indexPath.row])
                ),
                animated: true
            )
        case .categoryList:
            self.navigationController?.pushViewController(
                MealListViewController(
                    viewModel: MealListViewModel(categoryTitle: viewModel.categoryList[indexPath.row].categoryName ?? "")
                ),
                animated: true
            )
        case .mealList:
            self.navigationController?.pushViewController(
                MealDetailViewController(
                    viewModel: MealDetailViewModel(mealDetailData: viewModel.mealList[indexPath.row])
                ),
                animated: true
            )
        case .breakfast:
            self.navigationController?.pushViewController(
                MealDetailViewController(
                    viewModel: MealDetailViewModel(mealDetailData: viewModel.breakfastList[indexPath.row])
                ),
                animated: true
            )
        case .starter:
            self.navigationController?.pushViewController(
                MealDetailViewController(
                    viewModel: MealDetailViewModel(mealDetailData: viewModel.starterList[indexPath.row])
                ),
                animated: true
            )
        case .meat:
            self.navigationController?.pushViewController(
                MealDetailViewController(
                    viewModel: MealDetailViewModel(mealDetailData: viewModel.meatList[indexPath.row])
                ),
                animated: true
            )
        case .seafood:
            self.navigationController?.pushViewController(
                MealDetailViewController(
                    viewModel: MealDetailViewModel(mealDetailData: viewModel.seafoodList[indexPath.row])
                ),
                animated: true
            )
        case .vegetarian:
            self.navigationController?.pushViewController(
                MealDetailViewController(
                    viewModel: MealDetailViewModel(mealDetailData: viewModel.vegetarianList[indexPath.row])
                ),
                animated: true
            )
        case .pasta:
            self.navigationController?.pushViewController(
                MealDetailViewController(
                    viewModel: MealDetailViewModel(mealDetailData: viewModel.pastaList[indexPath.row])
                ),
                animated: true
            )
        case .dessert:
            self.navigationController?.pushViewController(
                MealDetailViewController(
                    viewModel: MealDetailViewModel(mealDetailData: viewModel.dessertList[indexPath.row])
                ),
                animated: true
            )
        }
    }
}

// MARK: - HomepageViewModelDelegate

extension HomepageViewController: HomepageViewModelDelegate {
    func didUpdateData() {
        print("didUpdateData executed")
        mealsCollectionView.reloadData()
    }
}
