//
//  StorageManager.swift
//  ChefAI
//
//  Created by Burak Özdemir on 13.05.2025.
//

import Foundation

class StorageManager {
    
    // MARK: - Singleton
    static let shared = StorageManager()
    private let userDefaults: UserDefaults
    
    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    // MARK: - Chat Methods
    
    func fetchChatMessages() -> [UserChatModel] {
        guard let chatData = userDefaults.data(forKey: fetchChatListKey()),
              let chatMessage = try? JSONDecoder().decode([UserChatModel].self, from: chatData) else {
            return []
        }
        return chatMessage
    }
    
    func addChatMessage(with message: UserChatModel) {
        var messages = fetchChatMessages()
        messages.append(message)
        if let data = try? JSONEncoder().encode(messages) {
            userDefaults.set(data, forKey: fetchChatListKey())
        }
    }
    
    func removeAllChatMessages() {
        var messages = fetchChatMessages()
        messages.removeAll()
        if let data = try? JSONEncoder().encode(messages) {
            userDefaults.set(data, forKey: fetchChatListKey())
        }
    }
    
    // MARK: - User Methods
    
    func loadImageFromDisk(userID: String) -> Data? {
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(userID)_profile_image.jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            print("Image found at path: \(fileURL.path)")
            return try? Data(contentsOf: fileURL)
        } else {
            print("No image found for user: \(userID)")
            return nil
        }
    }

    func saveImageToDisk(imageData: Data, userID: String) {
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(userID)_profile_image.jpg")
        
        do {
            try imageData.write(to: fileURL)
            print("Image saved to disk: \(fileURL.path)")
        } catch {
            print("Error saving image to disk: \(error.localizedDescription)")
        }
    }
    
    
    func saveUsername(with username: String) {
        userDefaults.set(username, forKey: fetchUsernameKey())
    }
    
    func fetchUsername() -> String {
        return userDefaults.string(forKey: fetchUsernameKey()) ?? ""
    }
    
    // MARK: - Meal Methods
    
    func fetchFavouriteMeals() -> [Meal] {
        guard let mealData = userDefaults.data(forKey: fetchMealsKey()),
              let meals = try? JSONDecoder().decode([Meal].self, from: mealData) else {
            return []
        }
        return meals
    }
    
    func addFavouriteMeals(with stateValue: Bool, for mealData: Meal) {
        var meals = fetchFavouriteMeals()
        
        guard !meals.contains(where: { $0.mealID == mealData.mealID }) else { return }

        meals.append(mealData)

        if let data = try? JSONEncoder().encode(meals) {
            userDefaults.set(data, forKey: fetchMealsKey())
            userDefaults.set(stateValue, forKey: mealData.mealID ?? "")
        }
    }
    
    func deleteFavouriteMeals(with stateValue: Bool, for mealID: String) {
        var meals = fetchFavouriteMeals()

        if let index = meals.firstIndex(where: { $0.mealID == mealID }) {
            meals.remove(at: index)

            if let data = try? JSONEncoder().encode(meals) {
                userDefaults.set(data, forKey: fetchMealsKey())
                userDefaults.set(stateValue, forKey: mealID)
            }
        }
    }
    
    // MARK: - Favourite Methods
    
    func fetchFavouriteState(for mealID: String) -> Bool {
        return userDefaults.bool(forKey: mealID)
    }
    
    func setFavouriteState(with stateValue: Bool, for mealID: String) {
        userDefaults.set(stateValue, forKey: mealID)
    }
    
    // MARK: - Ingredient Methods
    
    func fetchIngredientsList() -> [Ingredient] {
        guard let ingredientData = userDefaults.data(forKey: fetchIngredientsKey()),
              let meals = try? JSONDecoder().decode([Ingredient].self, from: ingredientData) else {
            return []
        }
        return meals
    }
    
    func addIngredientsList(with ingredientData: Ingredient) {
        var ingredientList = fetchIngredientsList()
        
        guard !ingredientList.contains(where: { $0.ingredientID == ingredientData.ingredientID }) else { return }

        ingredientList.append(ingredientData)
        if let data = try? JSONEncoder().encode(ingredientList) {
            userDefaults.set(data, forKey: fetchIngredientsKey())
        }
    }
    
    func deleteIngredientsList(for ingredientID: String) {
        var ingredientList = fetchIngredientsList()

        if let index = ingredientList.firstIndex(where: { $0.ingredientID == ingredientID }) {
            ingredientList.remove(at: index)

            if let data = try? JSONEncoder().encode(ingredientList) {
                userDefaults.set(data, forKey: fetchIngredientsKey())
            }
        }
    }
}

// MARK: - Privates

private extension StorageManager {
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func fetchChatListKey() -> String {
        let uid = AuthService.fetchUserID()
        return "com.ChefAI.MessageList.\(uid)"
    }
    
    func fetchUsernameKey() -> String {
        let uid = AuthService.fetchUserID()
        return "com.ChefAI.UserData.\(uid)"
    }
    
    func fetchMealsKey() -> String {
        let uid = AuthService.fetchUserID()
        return "com.ChefAI.Meals.\(uid)"
    }
    
    func fetchIngredientsKey() -> String {
        let uid = AuthService.fetchUserID()
        return "com.ChefAI.Ingredients.\(uid)"
    }
}
