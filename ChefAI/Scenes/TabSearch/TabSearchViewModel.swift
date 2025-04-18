//
//  TabSearchViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 18.04.2025.
//

import Foundation

protocol TabSearchViewModelProtocol: AnyObject {
    func didUpdateData()
}

class TabSearchViewModel {
    private let service: MealServiceProtocol
    weak var delegate: TabSearchViewModelProtocol?
    var mostSearchMealList: [Meal] = []
    
    init(service: MealService = .init()) {
        self.service = service
        
        fetchMostSearchList()
    }
    
    func fetchMostSearchList() {
        service.fetchMealList { [weak self] searchMealList in
            guard let self else { return }
            switch searchMealList {
            case .success(let mealList):
                self.mostSearchMealList = mealList.meals
                print(mealList.meals)
                DispatchQueue.main.async {
                    self.delegate?.didUpdateData()
                }
            case .failure(let error):
                print("Error fetching meals: \(error.errorMessage)")
            }
        }
    }
}
