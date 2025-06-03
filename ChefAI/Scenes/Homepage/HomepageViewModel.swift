//
//  HomepageViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

protocol HomepageViewModelDelegate: AnyObject {
    func didUpdateData()
}

// MARK: - HomepageViewModel

class HomepageViewModel {
    private let service: MealServiceProtocol
    weak var delegate: HomepageViewModelDelegate?
    
    var dailyMealList: [Meal] = []
    var categoryList: [Category] = []
    var ingredientList: [Ingredient] = []
    var mealList: [Meal] = []
    var breakfastList: [Meal] = []
    var starterList: [Meal] = []
    var meatList: [Meal] = []
    var seafoodList: [Meal] = []
    var vegetarianList: [Meal] = []
    var pastaList: [Meal] = []
    var dessertList: [Meal] = []
    
    var sectionList: [String] = [
        "Günün Yemeği",
        "Kategoriler",
        "Popüler Yemekler",
        "Kahvaltı",
        "Çorbalar",
        "Et Yemekleri",
        "Deniz Ürünleri",
        "Vejeteryan",
        "Makarnalar",
        "Tatlılar"
    ]
    
    lazy var categoryNameList: [String] = [
        "Breakfast",
        "Starter",
        "Chicken",
        "Beef",
        "Seafood",
        "Vegetarian",
        "Pasta",
        "Dessert"
    ]
    
    init(service: MealService = .init()) {
        self.service = service
        
        fetchDailyMeal()
        fetchIngredientList()
        fetchCategories()
        fetchMealList()
        
        for categoryName in categoryNameList {
            fetchListWithCategory(categoryTitle: categoryName)
        }
    }
}

// MARK: - Publics

extension HomepageViewModel {
    func fetchDailyMeal() {
        service.fetchDailyMeal { [weak self] dailyMealData in
            guard let self else { return }
            switch dailyMealData {
            case .success(let dailyMeal):
                self.dailyMealList = dailyMeal.meals
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData()
                }
            case .failure(let error):
                print("Daily meal error: \(error.errorMessage)")
            }
        }
    }
    
    func fetchIngredientList() {
        service.fetchIngredientList { [weak self] ingredientList in
            guard let self else { return }
            switch ingredientList {
            case .success(let ingredients):
                self.ingredientList = ingredients.ingredientList
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData()
                }
            case .failure(let error):
                print("Ingredients error: \(error.errorMessage)")
            }
        }
    }
    
    func fetchCategories() {
        service.fetchMealCategories { [weak self] categoryList in
            guard let self else { return }
            switch categoryList {
            case .success(let categoryList):
                self.categoryList = categoryList.categories
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData()
                }
            case .failure(let error):
                print("Categories error: \(error.errorMessage)")
            }
        }
    }
    
    func fetchMealList() {
        service.fetchMealList { [weak self] mealList in
            guard let self else { return }
            switch mealList {
            case .success(let mealList):
                self.mealList = mealList.meals
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData()
                }
            case .failure(let error):
                print("Meal list error: \(error.errorMessage)")
            }
        }
    }
    
    func fetchListWithCategory(categoryTitle: String) {
        let categoryType: CategoryType = .init(categoryText: categoryTitle)
        
        service.fetchMealListByCategory(category: categoryTitle) { [weak self] categoryList in
            guard let self else { return }
            
            switch categoryList {
            case .success(let categories):
                switch categoryType {
                case .breakfast:
                    self.breakfastList = categories.meals
                case .starter:
                    self.starterList = categories.meals
                case .chicken, .beef:
                    self.meatList.append(contentsOf: categories.meals)
                case .seafood:
                    self.seafoodList = categories.meals
                case .vegetarian:
                    self.vegetarianList = categories.meals
                case .pasta:
                    self.pastaList = categories.meals
                case .dessert:
                    self.dessertList = categories.meals
                }
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData()
                }
            case .failure(let error):
                print("\(categoryTitle) error: \(error.errorMessage)")
            }
        }
    }
}
