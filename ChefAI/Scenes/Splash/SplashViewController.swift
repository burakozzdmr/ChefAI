//
//  ViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 5.03.2025.
//

import UIKit
import SnapKit
import FirebaseAuth
import Lottie

// MARK: - SplashViewController

class SplashViewController: UIViewController {

    // MARK: - Properties
    
    private let appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .splash
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let loadingAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loadingAnimation")
        animationView.animationSpeed = 1
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureUI()
    }
}

// MARK: - Privates

private extension SplashViewController {
    func addViews() {
        view.addSubview(appLogoImageView)
        view.addSubview(loadingAnimationView)
    }
    
    func configureConstraints() {
        appLogoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(256)
        }
        
        loadingAnimationView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(128)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .customBackgroundColor2
        addViews()
        configureConstraints()
        splashToTabBar()
    }
    
    func splashToTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                return
            }
            let authNavController = UINavigationController(rootViewController: LoginViewController())
            let tabBarNavController = UINavigationController(rootViewController: TabBarController())
            
            UIView.transition(with: sceneDelegate.window!, duration: 0.75, options: .transitionCrossDissolve) {
                if Auth.auth().currentUser == nil {
                    sceneDelegate.window?.rootViewController = authNavController
                } else {
                    sceneDelegate.window?.rootViewController = tabBarNavController
                }
            }
        }
    }
}
