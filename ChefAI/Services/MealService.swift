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
}

class MealService {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManager = .init()) {
        self.networkManager = networkManager
    }
}

// MARK: - Privates

private extension MealService {
    func prepareRequestURL(_ endpoint: Endpoint) -> Result<URLRequest, NetworkError> {
        guard var urlComponents = URLComponents(string: endpoint.baseURL + NetworkConstants.mealApiKey + "/" + endpoint.path) else {
            print(NetworkError.invalidURL.errorMessage)
            return .failure(.invalidURL)
        }
        
        urlComponents.queryItems = endpoint.queryItems
        
        guard let requestURL = urlComponents.url else {
            print(NetworkError.requestFailedError.errorMessage)
            return .failure(.requestFailedError)
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = endpoint.method.rawValue
        return .success(request)
    }
}

// MARK: - MealServiceProtocol

extension MealService: MealServiceProtocol {
    func searchMealList(searchText: String, completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        let request = prepareRequestURL(Endpoint.search(searchText))
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: MealModel.self,
                completion: completion
            )
        case .failure:
            print("Error message: \(NetworkError.requestFailedError.errorMessage)")
        }
    }
    
    func fetchDailyMeal(completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        let request = prepareRequestURL(Endpoint.random)
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: MealModel.self,
                completion: completion
            )
        case .failure:
            print("Error message: \(NetworkError.requestFailedError.errorMessage)")
        }
    }
    
    func fetchMealCategories(completion: @escaping (Result<CategoryModel, NetworkError>) -> Void) {
        let request = prepareRequestURL(Endpoint.categories)
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: CategoryModel.self,
                completion: completion
            )
        case .failure:
            print("Error Message: \(NetworkError.requestFailedError.errorMessage)")
        }
    }
    
    func fetchMealList(completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        let request = prepareRequestURL(Endpoint.randomSelection)
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: MealModel.self,
                completion: completion
            )
        case .failure:
            print("Error Message: \(NetworkError.requestFailedError.errorMessage)")
        }
    }
    
    func fetchIngredientList(completion: @escaping (Result<IngredientModel, NetworkError>) -> Void) {
        let request = prepareRequestURL(Endpoint.list("i"))
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: IngredientModel.self,
                completion: completion
            )
        case .failure:
            print("Error Message: \(NetworkError.requestFailedError.errorMessage)")
        }
    }
    
    func fetchMealListByCategory(category: String, completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        let request = prepareRequestURL(Endpoint.filter("c", category))
        
        switch request {
        case .success(let request):
            networkManager.sendRequest(
                request: request,
                as: MealModel.self,
                completion: completion
            )
        case .failure:
            print("Error Message: \(NetworkError.requestFailedError.errorMessage)")
        }
    }
}
