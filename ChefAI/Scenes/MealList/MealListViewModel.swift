//
//  MealListViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 13.03.2025.
//

import Foundation

protocol MealListViewModelProtocol: AnyObject {
    func didUpdateData()
}

class MealListViewModel {
    private(set) var mealListByCategory: [MealList] = []
    private let service: MealServiceProtocol
    weak var delegate: MealListViewModelProtocol?
    let categoryTitle: String
    
    init(service: MealService = .init(), categoryTitle: String) {
        self.service = service
        self.categoryTitle = categoryTitle
        
        fetchMealListByCategory(categoryTitle: categoryTitle)
    }
    
    func fetchMealListByCategory(categoryTitle: String) {
        service.fetchMealListByCategory(category: categoryTitle) { [weak self] categoryMealList in
            guard let self else { return }
            switch categoryMealList {
            case .success(let mealListByCategory):
                self.mealListByCategory = mealListByCategory.meals
                delegate?.didUpdateData()
            case .failure:
                print("Error Message: \(NetworkError.emptyDataError.errorMessage)")
            }
        }
    }
    
    func getCategoryTitle() -> String {
        return ""
    }
}
