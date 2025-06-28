//
//  MealDetailViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 18.03.2025.
//

import Foundation

class MealDetailViewModel {
    
    let mealDetailData: Meal
    private let service: MealServiceProtocol
    weak var outputDelegate: MealDetailControllerProtocol?
    
    init(service: MealService = .init(), mealDetailData: Meal) {
        self.mealDetailData = mealDetailData
        self.service = service
        
        fetchMealDetails()
    }
    
    func fetchMealDetails() {
        service.fetchMealListByMealID(mealID: mealDetailData.mealID ?? "") { [weak self] mealList in
            guard let self else { return }
            
            switch mealList {
            case .success(let meals):
                guard let safeMealsData = meals.meals.first else { return }
                DispatchQueue.main.async {
                    self.outputDelegate?.fetchDetailData(mealDetailData: safeMealsData)
                }
                
            case .failure(let error):
                print(error.errorMessage)
            }
        }
    }
    
    func addFavouriteMeals(with stateValue: Bool) {
        StorageManager.shared.addFavouriteMeals(with: stateValue, for: mealDetailData)
    }
    
    func deleteFavouriteMeals(with stateValue: Bool) {
        StorageManager.shared.deleteFavouriteMeals(with: stateValue, for: mealDetailData.mealID ?? "")
    }
    
    func fetchFavouriteState() -> Bool {
        return StorageManager.shared.fetchFavouriteState(for: mealDetailData.mealID ?? "")
    }
}
