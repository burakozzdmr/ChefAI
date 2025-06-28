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
    
    func fetchChatMessages() -> [UserChatModel] {
        guard let chatData = userDefaults.data(forKey: getChatListKey()),
              let chatMessage = try? JSONDecoder().decode([UserChatModel].self, from: chatData) else {
            return []
        }
        return chatMessage
    }
    
    func addChatMessage(with message: UserChatModel) {
        var messages = fetchChatMessages()
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
    
    func fetchFavouriteMeals() -> [Meal] {
        guard let mealData = userDefaults.data(forKey: getMealsKey()),
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
            userDefaults.set(data, forKey: getMealsKey())
            userDefaults.set(stateValue, forKey: mealData.mealID ?? "")
        }
    }
    
    func deleteFavouriteMeals(with stateValue: Bool, for mealID: String) {
        var meals = fetchFavouriteMeals()

        if let index = meals.firstIndex(where: { $0.mealID == mealID }) {
            meals.remove(at: index)

            if let data = try? JSONEncoder().encode(meals) {
                userDefaults.set(data, forKey: getMealsKey())
                userDefaults.set(stateValue, forKey: mealID)
            }
        }
    }
    
    func fetchFavouriteState(for mealID: String) -> Bool {
        return userDefaults.bool(forKey: mealID)
    }
    
    func setFavouriteState(with stateValue: Bool, for mealID: String) {
        userDefaults.set(stateValue, forKey: mealID)
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
        let uid = AuthService.fetchUserID()
        return "com.ChefAI.Meals.\(uid)"
    }
}
