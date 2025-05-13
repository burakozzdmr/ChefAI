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
    private let defaultsKey = "com.ChefAI.MessageList"
    
    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func fetchChatMessages() -> [UserChatModel] {
        guard let chatData = userDefaults.data(forKey: defaultsKey),
              let chatMessage = try? JSONDecoder().decode([UserChatModel].self, from: chatData) else {
            return []
        }
        return chatMessage
    }
    
    func addChatMessage(message: UserChatModel) {
        var messages = fetchChatMessages()
        messages.append(message)
        if let data = try? JSONEncoder().encode(messages) {
            userDefaults.set(data, forKey: defaultsKey)
        }
    }
}
