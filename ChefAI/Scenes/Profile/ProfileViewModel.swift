//
//  ProfileViewModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 12.04.2025.
//

import UIKit
import Photos

enum PhotoPickerAction {
    case showPhotoLibrary
    case showPermissionDeniedAlert
}

class ProfileViewModel {
    var permissionResult: ((PhotoPickerAction) -> Void)?
    private let authService: AuthServiceProtocol
    
    let settingsList: [SettingsModel] = [
        SettingsModel(image: "shield.fill", name: "Privacy Policy"),
        SettingsModel(image: "star.fill", name: "Rate Us"),
        SettingsModel(image: "crown.fill", name: "Upgrade to Premium"),
        SettingsModel(image: "arrow.right.square.fill", name: "Log Out"),
    ]
    
    init(authService: AuthService = .init()) {
        self.authService = authService
        loadProfilePhoto()
    }
    
    func handleGalleryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            permissionResult?(.showPhotoLibrary)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { result in
                DispatchQueue.main.async {
                    switch result {
                    case .authorized:
                        self.permissionResult?(.showPhotoLibrary)
                    default:
                        self.permissionResult?(.showPermissionDeniedAlert)
                    }
                }
            }
        case .denied, .restricted, .limited:
            permissionResult?(.showPermissionDeniedAlert)
            
        default:
            break
        }
    }
    
    func loadProfilePhoto() {
        
    }
    
    func addProfilePhoto() {
        
    }
    
    func logOut(completion: @escaping (Error?) -> Void) {
        authService.signOut(completion: completion)
    }
}
