//
//  MealService.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

// MARK: - Protocools

protocol MealServiceProtocol {
    func prepareRequestURL(_ endpoint: Endpoint) -> Result<URLRequest, NetworkError>
    func searchMealList(_ endpoint: Endpoint, searchText: String, completion: @escaping (Result<MealModel, NetworkError>) -> Void)
    func fetchDailyMeal(_ endpoint: Endpoint, completion: @escaping (Result<MealModel, NetworkError>) -> Void)
    func fetchMealCategories(_ endpoint: Endpoint, completion: @escaping (Result<CategoryModel, NetworkError>) -> Void)
    func fetchMealList(_ endpoint: Endpoint, completion: @escaping (Result<MealModel, NetworkError>) -> Void)
}

class MealService {}

// MARK: - MealServiceProtocol

extension MealService: MealServiceProtocol {
    func prepareRequestURL(_ endpoint: Endpoint) -> Result<URLRequest, NetworkError> {
        guard var urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path) else {
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
    
    func searchMealList(_ endpoint: Endpoint, searchText: String, completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        let request = prepareRequestURL(Endpoint.search(searchText))
        
        switch request {
        case .success(let request):
            NetworkManager.shared.executeSearchMealList(request: request, searchText: searchText, completion: completion)
        case .failure:
            print("Error message: \(NetworkError.requestFailedError.errorMessage)")
        }
    }
    
    func fetchDailyMeal(_ endpoint: Endpoint, completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        let request = prepareRequestURL(Endpoint.random)
        
        switch request {
        case .success(let request):
            NetworkManager.shared.executeDailyMeal(request: request, completion: completion)
        case .failure:
            print("Error message: \(NetworkError.requestFailedError.errorMessage)")
        }
    }
    
    func fetchMealCategories(_ endpoint: Endpoint, completion: @escaping (Result<CategoryModel, NetworkError>) -> Void) {
        let request = prepareRequestURL(Endpoint.categories)
        
        switch request {
        case .success(let request):
            NetworkManager.shared.executeMealCategories(request: request, completion: completion)
        case .failure:
            print("Error Message: \(NetworkError.requestFailedError.errorMessage)")
        }
    }
    
    func fetchMealList(_ endpoint: Endpoint, completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        let request = prepareRequestURL(Endpoint.randomSelection)
        
        switch request {
        case .success(let request):
            NetworkManager.shared.executeMealList(request: request, completion: completion)
        case .failure:
            print("Error Message: \(NetworkError.requestFailedError.errorMessage)")
        }
    }
}
