//
//  FavouriteViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 28.06.2025.
//

import Foundation

class FavouriteViewModel {
    private(set) var favouriteMealList: [Meal] = []
    
    func fetchFavouriteMeals(for userID: String) {
        favouriteMealList = StorageManager.shared.fetchFavouriteMeals(userID: userID)
    }
}
