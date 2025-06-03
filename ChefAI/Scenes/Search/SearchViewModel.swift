//
//  SearchViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 18.04.2025.
//

import Foundation

protocol SearchViewModelProtocol: AnyObject {
    func didUpdateData()
}

class SearchViewModel {
    private let mealService: MealServiceProtocol
    private(set) var searchMealList: [Meal] = []
    weak var delegate: SearchViewModelProtocol?
    
    init(mealService: MealService = .init()) {
        self.mealService = mealService
    }
    
    func searchMeal(searchText: String) {
        mealService.searchMealList(searchText: searchText) { [weak self] searchMealList in
            guard let self else { return }
            
            switch searchMealList {
            case .success(let mealList):
                self.searchMealList = mealList.meals
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData()
                }
            case .failure(let error):
                print(error.errorMessage)
            }
        }
    }
}
