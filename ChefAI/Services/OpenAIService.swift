//
//  OpenAIService.swift
//  ChefAI
//
//  Created by Burak Özdemir on 30.04.2025.
//

import Foundation

protocol OpenAIServiceProtocol {
    func prepareRequestURL(_ endpoint: Endpoint) -> Result<URLRequest, NetworkError>
    func sendPrompt(prompt: String, completion: @escaping (Result<String, NetworkError>) -> Void)
}

// MARK: - OpenAIService

class OpenAIService {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManager = .init()) {
        self.networkManager = networkManager
    }
}

// MARK: - OpenAIServiceProtocol

extension OpenAIService: OpenAIServiceProtocol {
    func prepareRequestURL(_ endpoint: Endpoint) -> Result<URLRequest, NetworkError> {
        guard let urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            return .failure(.invalidURL)
        }
        
        guard let requestURL = urlComponents.url else {
            return .failure(.requestFailedError)
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("Bearer \(NetworkConstants.gptApiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return .success(request)
    }
    
    func sendPrompt(prompt: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let request = prepareRequestURL(Endpoint.completions)
        
        switch request {
        case .success(var httpRequest):
            let httpBody: [String: Any] = [
                "model": "gpt-4o-mini",
                "messages": [
                    ["role": "system", "content": "Sen bir mutfak şefisin ve buna göre cevaplar ver sadece."],
                    ["role": "user", "content": prompt]
                ]
            ]
            httpRequest.httpBody = try? JSONSerialization.data(withJSONObject: httpBody)
            
            networkManager.sendPromptRequest(
                request: httpRequest,
                completion: completion
            )
        case .failure:
            print(NetworkError.requestFailedError.errorMessage)
        }
    }
}
