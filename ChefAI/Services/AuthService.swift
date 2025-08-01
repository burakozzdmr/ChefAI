//
//  AuthService.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation
import FirebaseAuth

// MARK: - AuthService Protocol

protocol AuthServiceProtocol {
    func signIn(with email: String, and password: String, completion: @escaping (Error?) -> Void)
    func signUp(with email: String, and password: String, completion: @escaping (Error?) -> Void)
    func signOut(completion: @escaping (Error?) -> Void)
    static func fetchUserID() -> String
}

// MARK: - AuthService

class AuthService {}

// MARK: - AuthServiceProtocol

extension AuthService: AuthServiceProtocol {
    func signIn(with email: String, and password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func signUp(with email: String, and password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    static func fetchUserID() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
}
