//
//  GeminiModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 1.05.2025.
//

import Foundation

struct GeminiRequest: Codable {
    let contents: [Content]
}

struct Content: Codable {
    let parts: [Part]
}

struct Part: Codable {
    let text: String
}

struct GeminiResponse: Codable {
    let candidates: [Candidate]
}

struct Candidate: Codable {
    let content: Content
}
