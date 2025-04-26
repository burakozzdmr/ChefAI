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
    var parameters: [String: Any]? { get }
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
    case completions
}

// MARK: - EndpointProtocol

extension Endpoint: EndpointProtocol {
    var baseURL: String {
        switch self {
        case .completions:
            return NetworkConstants.gptBaseURL
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
        case .completions:
            return NetworkConstants.completionsPath
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
        case .completions:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .completions:
            return .POST
        default:
            return .GET
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        return nil
    }
}
