//
//  NetworkManager.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func sendRequest<T: Codable>(request: URLRequest, as: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
    func sendPromptRequest(request: URLRequest, completion: @escaping (Result<String, NetworkError>) -> Void)
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
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            } else {
                print("empty error here we go ")
            }
            
            guard let data = data else {
                completion(.failure(.emptyDataError))
                return
            }
            
            do {
                let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                print(jsonResponse)
                completion(.success(jsonResponse))
            } catch {
                print("JSON DECODE ERROR: \(error.localizedDescription)")
                completion(.failure(.decodeError))
            }
        }
        .resume()
    }
    
    func sendPromptRequest(request: URLRequest, completion: @escaping (Result<String, NetworkError>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.invalidURL))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            } else {
                print("empty error here we go")
            }
            
            guard let data = data else {
                completion(.failure(.emptyDataError))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    print("GPT Response: \(content)")
                    completion(.success(content))
                } else {
                    completion(.failure(.decodeError))
                }
            } catch {
                print(NetworkError.customError(error))
            }
        }
        .resume()
    }
}
