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
        collectionView.contentInsetAdjustmentBehavior = .never
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
        button.setTitle("Ask to Chef", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.tintColor = .white
        button.backgroundColor = .customButton
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(askChefTapped), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: HomepageViewModel
    private let loadingView: LoadingView = .init()
    private var indexPath: IndexPath = .init()
    
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
    
    // MARK: - Methods
    
    private func dequeueAndConfigureMealCell(with indexPath: IndexPath, for mealData: Meal) -> UICollectionViewCell {
        let cell = mealsCollectionView.dequeueReusableCell(withReuseIdentifier: MealCell.identifier, for: indexPath) as! MealCell
        cell.configure(with: mealData)
        return cell
    }
    
    private func homepageToDetail(with mealData: Meal) {
        let detailController = MealDetailViewController(viewModel: MealDetailViewModel(mealDetailData: mealData))
        navigationController?.pushViewController(detailController, animated: true)
    }
}

// MARK: - Privates

private extension HomepageViewController {
    func addViews() {
        view.addSubview(mealsCollectionView)
        view.addSubview(askToChefButton)
        view.addSubview(loadingView)
    }
    
    func configureConstraints() {
        mealsCollectionView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        askToChefButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(128)
            $0.height.equalTo(48)
        }
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        view.backgroundColor = .customBackgroundColor2
        navigationController?.navigationBar.isHidden = true
        loadingView.isHidden = false
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

@objc private extension HomepageViewController {
    func askChefTapped() {
        let chefVC = ChefViewController()
        chefVC.modalPresentationStyle = .fullScreen
        present(chefVC, animated: true, completion: nil)
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
            return dequeueAndConfigureMealCell(with: indexPath, for: viewModel.dailyMealList[indexPath.row])
            
        case .ingredientList:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCell.identifier, for: indexPath) as! IngredientCell
            cell.configure(with: viewModel.ingredientList[indexPath.row])
            cell.ingredientDelegate = self
            cell.indexPath = indexPath
            return cell
            
        case .categoryList:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            cell.configure(with: viewModel.categoryList[indexPath.row])
            return cell
            
        case .mealList:
            return dequeueAndConfigureMealCell(with: indexPath, for: viewModel.mealList[indexPath.row])
            
        case .breakfast:
            return dequeueAndConfigureMealCell(with: indexPath, for: viewModel.breakfastList[indexPath.row])
            
        case .starter:
            return dequeueAndConfigureMealCell(with: indexPath, for: viewModel.starterList[indexPath.row])
            
        case .meat:
            return dequeueAndConfigureMealCell(with: indexPath, for: viewModel.meatList[indexPath.row])
            
        case .seafood:
            return dequeueAndConfigureMealCell(with: indexPath, for: viewModel.seafoodList[indexPath.row])
            
        case .vegetarian:
            return dequeueAndConfigureMealCell(with: indexPath, for: viewModel.vegetarianList[indexPath.row])
            
        case .pasta:
            return dequeueAndConfigureMealCell(with: indexPath, for: viewModel.pastaList[indexPath.row])
            
        case .dessert:
            return dequeueAndConfigureMealCell(with: indexPath, for: viewModel.dessertList[indexPath.row])
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
            homepageToDetail(with: viewModel.dailyMealList[indexPath.row])
            
        case .ingredientList: break
            
        case .categoryList:
            navigationController?.pushViewController(
                MealListViewController(
                    viewModel: MealListViewModel(categoryTitle: viewModel.categoryList[indexPath.row].categoryName ?? "")
                ),
                animated: true
            )
            
        case .mealList:
            homepageToDetail(with: viewModel.mealList[indexPath.row])
            
        case .breakfast:
            homepageToDetail(with: viewModel.breakfastList[indexPath.row])
            
        case .starter:
            homepageToDetail(with: viewModel.starterList[indexPath.row])
            
        case .meat:
            homepageToDetail(with: viewModel.meatList[indexPath.row])
            
        case .seafood:
            homepageToDetail(with: viewModel.seafoodList[indexPath.row])
            
        case .vegetarian:
            homepageToDetail(with: viewModel.vegetarianList[indexPath.row])
            
        case .pasta:
            homepageToDetail(with: viewModel.pastaList[indexPath.row])
            
        case .dessert:
            homepageToDetail(with: viewModel.dessertList[indexPath.row])
        }
    }
}

// MARK: - HomepageViewModelDelegate

extension HomepageViewController: HomepageViewModelDelegate {
    func didUpdateData() {
        DispatchQueue.main.async {
            self.mealsCollectionView.reloadData()
            self.loadingView.isHidden = true
        }
    }
}

// MARK: - IngredientDelegate

extension HomepageViewController: IngredientProtocol {
    func addButtonTapped(at indexPath: IndexPath) {
        AlertManager.shared.presentAlert(
            with: "ChefAI",
            and: "Added to ingredients.",
            buttons: [
                UIAlertAction(title: "OK", style: .default) { _ in
                    self.viewModel.addIngredientsList(for: self.viewModel.ingredientList[indexPath.row])
                }
            ],
            from: self
        )
    }
}

