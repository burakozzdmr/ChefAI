//
//  UserChatType .swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.05.2025.
//

import Foundation
import FirebaseAuth

enum UserChatType {
    case gemini
    case normalUser
    
    init(for userEmail: String) {
        let userID: String = Auth.auth().currentUser?.email ?? ""
        
        switch userEmail {
        case userID:
            self = .normalUser
        default:
            self = .gemini
        }
    }
}
