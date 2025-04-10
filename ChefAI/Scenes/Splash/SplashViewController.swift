//
//  ViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 5.03.2025.
//

import UIKit
import SnapKit
import FirebaseAuth

// MARK: - SplashViewController

class SplashViewController: UIViewController {

    // MARK: - Properties
    
    private let appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .customAppLogo
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let loadingIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .large
        indicatorView.color = .customButton
        indicatorView.hidesWhenStopped = true
        indicatorView.startAnimating()
        return indicatorView
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
        view.addSubview(loadingIndicatorView)
    }
    
    func configureConstraints() {
        appLogoImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(256)
        }
        
        loadingIndicatorView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(96)
            make.centerX.equalToSuperview()
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
