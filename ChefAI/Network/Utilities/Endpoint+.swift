//
//  Endpoint+.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

enum Endpoint {
    case search
    case lookup
    case random
    case randomSelection
    case categories
    case latest
    case list
    case filter
}

extension Endpoint: EndpointProtocol {
    var baseURL: String {
        return NetworkConstants.baseURL
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
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search, .lookup, .random, .randomSelection, .categories, .latest, .list, .filter:
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
