//
//  FavouriteViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 28.06.2025.
//

import Foundation

class FavouriteViewModel {
    private(set) var favouriteMealList: [Meal] = []
    weak var controllerDelegate: FavouriteControllerProtocol?
    
    func fetchFavouriteMeals(for userID: String) {
        favouriteMealList = StorageManager.shared.fetchFavouriteMeals(userID: userID)
        controllerDelegate?.didUpdateData()
    }
    
    func deleteFavouriteMeals(for mealID: String) {
        StorageManager.shared.deleteFavouriteMeals(with: mealID)
        fetchFavouriteMeals(for: AuthService.fetchUserID())
    }
}
