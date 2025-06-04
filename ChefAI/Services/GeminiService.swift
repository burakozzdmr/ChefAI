//
//  GeminiService.swift
//  ChefAI
//
//  Created by Burak Özdemir on 1.05.2025.
//

import Foundation

protocol GeminiServiceProtocol {
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
    func sendPrompt(prompt: String, completion: @escaping (Result<GeminiResponse, NetworkError>) -> Void) {
        let request = Endpoint.prepareRequestURL(.gemini)
        
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
        case .failure(let error):
            print(error.errorMessage)
        }
    }
}
