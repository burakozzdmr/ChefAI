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
    private var debounceWorkItem: DispatchWorkItem?
    
    init(mealService: MealService = .init()) {
        self.mealService = mealService
    }
    
    func searchMeal(searchText: String) {
        debounceWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.mealService.searchMealList(searchText: searchText) { result in
                switch result {
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
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }
}
