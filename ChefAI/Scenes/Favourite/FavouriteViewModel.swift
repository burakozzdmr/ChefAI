//
//  FavouriteViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 28.06.2025.
//

import Foundation

class FavouriteViewModel {
    private(set) var favouriteMealList: [Meal] = []
    private let service: MealServiceProtocol
    
    init(service: MealService = .init()) {
        self.service = service
    }
}
