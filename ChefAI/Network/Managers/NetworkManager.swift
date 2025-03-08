//
//  NetworkManager.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

// MARK: - NetworkManager

class NetworkManager {
    static let shared = NetworkManager()
    private let service: MealServiceProtocol
    private let session: URLSession
    
    private init(service: MealService = .init()) {
        self.service = service
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
                print("JSON DECODE ERROR: \(NetworkError.decodeError.errorMessage)")
            }
        }
        .resume()
    }
}

// MARK: - Publics

extension NetworkManager {
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
}
