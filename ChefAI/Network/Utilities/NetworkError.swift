//
//  NetworkError.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailedError
    case decodeError
    case emptyDataError
    case cannotFindHost
    case statusCodeError(Int)
    case customError(Error)
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid URL Error"
        case .requestFailedError:
            return "Request failed error"
        case .decodeError:
            return "decode error"
        case .emptyDataError:
            return "empty data error"
        case .cannotFindHost:
            return "can not find host"
        case .statusCodeError(let statusCode):
            return "HTTP Response Error Status Code -> \(statusCode)"
        case .customError(let error):
            return "Error Message: \(error.localizedDescription)"
        }
    }
}
