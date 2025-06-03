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
        guard let chatData = userDefaults.data(forKey: chatListKey()),
              let chatMessage = try? JSONDecoder().decode([UserChatModel].self, from: chatData) else {
            return []
        }
        return chatMessage
    }
    
    func addChatMessage(with message: UserChatModel) {
        var messages = fetchChatMessages(userID: AuthService.fetchUserID())
        messages.append(message)
        if let data = try? JSONEncoder().encode(messages) {
            userDefaults.set(data, forKey: chatListKey())
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
        userDefaults.set(username, forKey: userNameKey())
    }
    
    func fetchUsername() -> String {
        return userDefaults.string(forKey: userNameKey()) ?? ""
    }
}

// MARK: - Privates

private extension StorageManager {
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func chatListKey() -> String {
        let uid = AuthService.fetchUserID()
        return "com.ChefAI.MessageList.\(uid)"
    }
    
    func userNameKey() -> String {
        let uid = AuthService.fetchUserID()
        return "com.ChefAI.UserData.\(uid)"
    }
}
