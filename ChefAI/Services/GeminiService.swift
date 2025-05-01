//
//  GeminiService.swift
//  ChefAI
//
//  Created by Burak Özdemir on 1.05.2025.
//

import Foundation

protocol GeminiServiceProtocol {
    func prepareRequestURL(_ endpoint: Endpoint) -> Result<URLRequest, NetworkError>
    func sendPrompt(prompt: String, completion: @escaping (Result<GeminiResponse, NetworkError>) -> Void)
}

// MARK: - GeminiService

class GeminiService {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManager = .init()) {
        self.networkManager = networkManager
    }
}

// MARK: - GeminiServiceProtocol

extension GeminiService: GeminiServiceProtocol {
    func prepareRequestURL(_ endpoint: Endpoint) -> Result<URLRequest, NetworkError> {
        guard var urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            return .failure(.invalidURL)
        }
        urlComponents.queryItems = endpoint.queryItems
        
        guard let requestURL = urlComponents.url else {
            return .failure(.requestFailedError)
        }
        
        var request: URLRequest = .init(url: requestURL)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("servise istek atılan request url stringi: ")
        print(request.url?.absoluteString ?? "invalid url string")
        return .success(request)
    }
    
    func sendPrompt(prompt: String, completion: @escaping (Result<GeminiResponse, NetworkError>) -> Void) {
        let request = prepareRequestURL(Endpoint.gemini)
        
        switch request {
        case .success(var httpRequest):
            let body = GeminiRequest(contents: [
                Content(parts: [Part(text: prompt)])
            ])
            
            do {
                httpRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                completion(.failure(.decodeError))
            }
            
            networkManager.sendRequest(
                request: httpRequest,
                as: GeminiResponse.self,
                completion: completion
            )
        case .failure:
            print(NetworkError.requestFailedError.errorMessage)
        }
    }
}
