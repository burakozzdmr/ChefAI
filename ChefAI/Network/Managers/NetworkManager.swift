//
//  NetworkManager.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func sendRequest<T: Codable>(request: URLRequest, as: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

// MARK: - NetworkManager

class NetworkManager {
    private let session: URLSession
    
    init() {
        self.session = URLSession(configuration: .default)
    }
}

// MARK: - NetworkManagerProtocol

extension NetworkManager: NetworkManagerProtocol {
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
                completion(.failure(.decodeError))
            }
        }
        .resume()
    }
}
