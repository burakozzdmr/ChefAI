//
//  NetworkManager.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func executeSearchMealList(request: URLRequest, searchText: String, completion: @escaping (Result<MealModel, NetworkError>) -> Void)
    func executeDailyMeal(request: URLRequest, completion: @escaping (Result<MealModel, NetworkError>) -> Void)
    func executeMealCategories(request: URLRequest, completion: @escaping (Result<CategoryModel, NetworkError>) -> Void)
    func executeMealList(request: URLRequest, completion: @escaping (Result<MealModel, NetworkError>) -> Void)
    func executeIngredientList(request: URLRequest, completion: @escaping (Result<IngredientModel, NetworkError>) -> Void)
    func executeMealListByCategory(request: URLRequest, completion: @escaping (Result<MealModel, NetworkError>) -> Void)
}

// MARK: - NetworkManager

class NetworkManager {
    private let session: URLSession
    
    init() {
        self.session = URLSession(configuration: .default)
    }
}

// MARK: - Privates

private extension NetworkManager {
    func sendRequest<T: Codable>(request: URLRequest, as: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.invalidURL))
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyDataError))
                return
            }
            
            do {
                let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(jsonResponse))
            } catch {
                print("JSON DECODE ERROR: \(error.localizedDescription)")
            }
        }
        .resume()
    }
}

// MARK: - NetworkManagerProtocol

extension NetworkManager: NetworkManagerProtocol {
    func executeSearchMealList(request: URLRequest, searchText: String, completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        sendRequest(
            request: request,
            as: MealModel.self,
            completion: completion
        )
    }
    
    func executeDailyMeal(request: URLRequest, completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        sendRequest(
            request: request,
            as: MealModel.self,
            completion: completion
        )
    }
    
    func executeMealCategories(request: URLRequest, completion: @escaping (Result<CategoryModel, NetworkError>) -> Void) {
        sendRequest(
            request: request,
            as: CategoryModel.self,
            completion: completion
        )
    }
    
    func executeMealList(request: URLRequest, completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        sendRequest(
            request: request,
            as: MealModel.self,
            completion: completion
        )
    }
    
    func executeIngredientList(request: URLRequest, completion: @escaping (Result<IngredientModel, NetworkError>) -> Void) {
        sendRequest(
            request: request,
            as: IngredientModel.self,
            completion: completion
        )
    }
    
    func executeMealListByCategory(request: URLRequest, completion: @escaping (Result<MealModel, NetworkError>) -> Void) {
        sendRequest(
            request: request,
            as: MealModel.self,
            completion: completion
        )
    }
}
