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
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData()
                }
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
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData()
                }
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
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData()
                }
            case .failure:
                print(NetworkError.emptyDataError.errorMessage)
            }
        }
    }
    
    func getNavigationTitle() -> String {
        let period: DayPeriodType = .init()
        
        switch period {
        case .morning:
            return "Günaydın ☀️"
        case .afternoon:
            return "İyi Günler 👋🏻"
        case .evening:
            return "İyi Akşamlar 🌙"
        case .night:
            return "İyi Geceler 🌙"
        }
    }
}
