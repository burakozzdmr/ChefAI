//
//  Endpoint+.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

// MARK: - Protocols

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    static func prepareRequestURL(_ endpoint: Endpoint) -> Result<URLRequest, NetworkError>
}

// MARK: - Enums

enum Endpoint {
    case search(String)
    case lookup(String)
    case random
    case randomSelection
    case categories
    case latest
    case list(String)
    case filter(String, String)
    case gemini
}

// MARK: - EndpointProtocol

extension Endpoint: EndpointProtocol {
    var baseURL: String {
        switch self {
        case .gemini:
            return NetworkConstants.geminiBaseURL
        default:
            return NetworkConstants.mealBaseURL
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return NetworkConstants.searchPath
        case .lookup:
            return NetworkConstants.lookupPath
        case .random:
            return NetworkConstants.randomPath
        case .randomSelection:
            return NetworkConstants.randomSelectionPath
        case .categories:
            return NetworkConstants.categoryPath
        case .latest:
            return NetworkConstants.latestPath
        case .list:
            return NetworkConstants.listPath
        case .filter:
            return NetworkConstants.filterPath
        case .gemini:
            return NetworkConstants.geminiPath
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let searchQuery):
            return [
                URLQueryItem(name: "s", value: searchQuery)
            ]
        case .lookup(let lookupQuery):
            return [
                URLQueryItem(name: "i", value: lookupQuery)
            ]
        case .random:
            return nil
        case .randomSelection:
            return nil
        case .categories:
            return nil
        case .latest:
            return nil
        case .list(let listType):
            return [
                URLQueryItem(name: "\(listType)", value: "list")
            ]
        case .filter(let ListType, let listQuery):
            return [
                URLQueryItem(name: "\(ListType)", value: "\(listQuery)")
            ]
        case .gemini:
            return [
                URLQueryItem(name: "key", value: NetworkConstants.geminiApiKey)
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .gemini:
            return .POST
        default:
            return .GET
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .gemini:
            return ["Content-Type": "application/json"]
        default:
            return nil
        }
    }
    
    static func prepareRequestURL(_ endpoint: Endpoint) -> Result<URLRequest, NetworkError> {
        switch endpoint {
        case .gemini:
            guard var urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path) else {
                return .failure(.invalidURL)
            }
            
            urlComponents.queryItems = endpoint.queryItems
            
            guard let requestURL = urlComponents.url else {
                return .failure(.requestFailedError)
            }
            
            var request = URLRequest(url: requestURL)
            request.httpMethod = endpoint.method.rawValue
            request.allHTTPHeaderFields = endpoint.headers
            return .success(request)
            
        default:
            guard var urlComponents = URLComponents(string: endpoint.baseURL + NetworkConstants.mealApiKey + endpoint.path) else {
                return .failure(.invalidURL)
            }
            
            urlComponents.queryItems = endpoint.queryItems
            
            guard let requestURL = urlComponents.url else {
                return .failure(.requestFailedError)
            }
            
            var request = URLRequest(url: requestURL)
            request.httpMethod = endpoint.method.rawValue
            return .success(request)
        }
    }
}
