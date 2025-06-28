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
    
    // MARK: - Publics
    
    func fetchChatMessages(userID: String) -> [UserChatModel] {
        guard let chatData = userDefaults.data(forKey: getChatListKey()),
              let chatMessage = try? JSONDecoder().decode([UserChatModel].self, from: chatData) else {
            return []
        }
        return chatMessage
    }
    
    func addChatMessage(with message: UserChatModel) {
        var messages = fetchChatMessages(userID: AuthService.fetchUserID())
        messages.append(message)
        if let data = try? JSONEncoder().encode(messages) {
            userDefaults.set(data, forKey: getChatListKey())
        }
    }
    
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
        userDefaults.set(username, forKey: getUserNameKey())
    }
    
    func fetchUsername() -> String {
        return userDefaults.string(forKey: getUserNameKey()) ?? ""
    }
    
    func fetchFavouriteMeals(userID: String) -> [Meal] {
        guard let mealData = userDefaults.data(forKey: getMealsKey()),
              let meals = try? JSONDecoder().decode([Meal].self, from: mealData) else {
            return []
        }
        return meals
    }
    
    func addFavouriteMeals(with mealData: Meal) {
        var meals = fetchFavouriteMeals(userID: AuthService.fetchUserID())
        meals.append(mealData)
        if let data = try? JSONEncoder().encode(meals) {
            userDefaults.set(data, forKey: getChatListKey())
        }
    }
    
    func deleteFavouriteMeals(with mealID: String) {
        var meals = fetchFavouriteMeals(userID: AuthService.fetchUserID())
        if !meals.isEmpty {
            meals.remove(at: Int(mealID) ?? Int())
        }
        if let data = try? JSONEncoder().encode(meals) {
            userDefaults.set(data, forKey: getMealsKey())
        }
    }
}

// MARK: - Privates

private extension StorageManager {
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func getChatListKey() -> String {
        let uid = AuthService.fetchUserID()
        return "com.ChefAI.MessageList.\(uid)"
    }
    
    func getUserNameKey() -> String {
        let uid = AuthService.fetchUserID()
        return "com.ChefAI.UserData.\(uid)"
    }
    
    func getMealsKey() -> String {
        return "com.ChefAI.Meals"
    }
}
