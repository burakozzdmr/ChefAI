//
//  StorageManager.swift
//  ChefAI
//
//  Created by Burak Özdemir on 13.05.2025.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults: UserDefaults
    private let chatListKey = "com.ChefAI.MessageList"
    private let latestMealsKey = "com.ChefAI.LatestMeals"
    private let userDataKey = "com.ChefAI.UserData"
    
    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func fetchChatMessages() -> [UserChatModel] {
        guard let chatData = userDefaults.data(forKey: chatListKey),
              let chatMessage = try? JSONDecoder().decode([UserChatModel].self, from: chatData) else {
            return []
        }
        return chatMessage
    }
    
    func addChatMessage(with message: UserChatModel) {
        var messages = fetchChatMessages()
        messages.append(message)
        if let data = try? JSONEncoder().encode(messages) {
            userDefaults.set(data, forKey: chatListKey)
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
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func saveUsername(with username: String) {
        userDefaults.set(username, forKey: userDataKey)
    }
    
    func fetchUsername() -> String {
        return userDefaults.string(forKey: userDataKey) ?? ""
    }
    
    func addLatestMeal(with selectedMeal: Meal) {
        var latestMealList = fetchLatestMeals()
        latestMealList.append(selectedMeal)
        if let data = try? JSONEncoder().encode(latestMealList) {
            if latestMealList.contains(where: { $0.mealID == selectedMeal.mealID }) && latestMealList.count >= 1 {
                return
            }
            userDefaults.set(data, forKey: latestMealsKey)
        }
    }
    
    func deleteLatestMeal(at mealID: String) {
        var latestMealList = fetchLatestMeals()
        latestMealList.removeAll { $0.mealID == mealID }
        if let data = try? JSONEncoder().encode(latestMealList) {
            userDefaults.set(data, forKey: latestMealsKey)
        }
    }
    
    func fetchLatestMeals() -> [Meal] {
        guard let latestMealsData = userDefaults.data(forKey: latestMealsKey),
              let latestMealList = try? JSONDecoder().decode([Meal].self, from: latestMealsData) else {
            return []
        }
        return latestMealList
    }
}
