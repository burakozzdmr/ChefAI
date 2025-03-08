//
//  HomepageViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

class HomepageViewModel {
    private let service: MealServiceProtocol
    var dailyMealList: [Meal] = []
    var categoryList: [Category] = []
    var mealList: [Meal] = []
    var sectionList: [String] = ["Günün Yemeği", "Kategoriler", "Popüler Yemekler"]
    
    init(service: MealService = .init()) {
        self.service = service
        
        fetchDailyMeal()
        fetchCategories()
        fetchMealList()
    }
    
    func fetchDailyMeal() {
        service.fetchDailyMeal { [weak self] dailyMealData in
            guard let self else { return }
            switch dailyMealData {
            case .success(let dailyMeal):
                self.dailyMealList = dailyMeal.meals
            case .failure:
                print(NetworkError.emptyDataError.errorMessage)
            }
        }
    }
    
    func fetchCategories() {
        service.fetchMealCategories { [weak self] categoryList in
            guard let self else { return }
            switch categoryList {
            case .success(let categoryList):
                self.categoryList = categoryList.categories
            case .failure:
                print(NetworkError.emptyDataError.errorMessage)
            }
        }
    }
    
    func fetchMealList() {
        service.fetchMealList { [weak self] mealList in
            guard let self else { return }
            switch mealList {
            case .success(let mealList):
                self.mealList = mealList.meals
            case .failure:
                print(NetworkError.emptyDataError.errorMessage)
            }
        }
    }
}
