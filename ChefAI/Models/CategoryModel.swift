//
//  CategoryModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

struct Category: Codable {
    let categoryID: String?
    let categoryName: String?
    let categoryImageURL: String?
    let categoryDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "idCategory"
        case categoryName = "strCategory"
        case categoryImageURL = "strCategoryThumb"
        case categoryDescription = "strCategoryDescription"
    }
}

struct CategoryModel: Codable {
    let categories: [Category]
}
