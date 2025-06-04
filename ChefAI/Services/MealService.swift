//
//  MealService.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

// MARK: - Protocools

protocol MealServiceProtocol {
    func searchMealList(searchText: String, completion: @escaping (Result<MealModel, NetworkError>) -> Void)
    func fetchDailyMeal(completion: @escaping (Result<MealModel, NetworkError>) -> Void)
    func fetchMealCategories(completion: @escaping (Result<CategoryModel, NetworkError>) -> Void)
    func fetchMealList(completion: @escaping (Result<MealModel, NetworkError>) -> Void)
    func fetchIngredientList(completion: @escaping (Result<IngredientModel, NetworkError>) -> Void)
    func fetchMealListByCategory(category: String, completion: @escaping (Result<MealModel, NetworkError>) -> Void)
    func fetchMealListByMealID(mealID: String, completion: @escaping (Result<MealModel, NetworkError>) -> Void)
}

class MealService {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManager = .init()) {
        self.networkManager = networkManager
    }
}

// MARK: - MealServiceProtocol

extension MealService: MealServiceProtocol {
    func searchMealList(searchText: String, completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        let request = Endpoint.prepareRequestURL(.search(searchText))
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: MealModel.self,
                completion: completion
            )
        case .failure(let error):
            print(error.errorMessage)
        }
    }
    
    func fetchDailyMeal(completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        let request = Endpoint.prepareRequestURL(.random)
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: MealModel.self,
                completion: completion
            )
        case .failure(let error):
            print(error.errorMessage)
        }
    }
    
    func fetchMealCategories(completion: @escaping (Result<CategoryModel, NetworkError>) -> Void) {
        let request = Endpoint.prepareRequestURL(.categories)
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: CategoryModel.self,
                completion: completion
            )
        case .failure(let error):
            print(error.errorMessage)
        }
    }
    
    func fetchMealList(completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        let request = Endpoint.prepareRequestURL(.randomSelection)
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: MealModel.self,
                completion: completion
            )
        case .failure(let error):
            print(error.errorMessage)
        }
    }
    
    func fetchIngredientList(completion: @escaping (Result<IngredientModel, NetworkError>) -> Void) {
        let request = Endpoint.prepareRequestURL(.list("i"))
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: IngredientModel.self,
                completion: completion
            )
        case .failure(let error):
            print(error.errorMessage)
        }
    }
    
    func fetchMealListByCategory(category: String, completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        let request = Endpoint.prepareRequestURL(.filter("c", category))
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: MealModel.self,
                completion: completion
            )
        case .failure(let error):
            print(error.errorMessage)
        }
    }
    
    func fetchMealListByMealID(mealID: String, completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        let request = Endpoint.prepareRequestURL(.lookup(mealID))
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: MealModel.self,
                completion: completion
            )
        case .failure(let error):
            print(error.errorMessage)
        }
    }
}
