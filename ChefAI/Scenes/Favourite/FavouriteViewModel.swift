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
    
    func fetchFavouriteMeals() {
        favouriteMealList = StorageManager.shared.fetchFavouriteMeals()
        controllerDelegate?.didUpdateData()
    }
}
