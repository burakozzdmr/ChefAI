//
//  IngredientViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 1.07.2025.
//

import Foundation

protocol IngredientViewModelInputProtocol: AnyObject {
    func deleteIngredients(for ingredientID: String)
}

class IngredientViewModel {
    private(set) var ingredientList: [Ingredient] = []
    weak var inputDelegate: IngredientViewModelInputProtocol?
    weak var outputDelegate: IngredientControllerOutputProtocol?
    
    init() {
        inputDelegate = self
    }
}

extension IngredientViewModel: IngredientViewModelInputProtocol {
    func deleteIngredients(for ingredientID: String) {
        
    }
}
