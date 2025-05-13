//
//  PresentMealDetailViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 11.05.2025.
//

import Foundation

class PresentMealDetailViewModel {
    let mealDetailData: Meal
    private let service: MealServiceProtocol
    weak var outputDelegate: MealDetailViewModelOutputProtocol?
    
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
                
            case .failure:
                print(NetworkError.emptyDataError.errorMessage)
            }
        }
    }
}
