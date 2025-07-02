//
//  RegisterResultViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 6.03.2025.
//

import UIKit
import SnapKit
import Lottie

// MARK: - RegisterResultViewController

class RegisterResultViewController: UIViewController {

    // MARK: - Properties
    
    private let successmarkImageView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "successAnimation")
        animationView.animationSpeed = 1
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
        return animationView
    }()
    
    private let thatsItLabel: UILabel = {
        let label = UILabel()
        label.text = "That's it!"
        label.font = .systemFont(ofSize: 48, weight: .black)
        label.textColor = .lightGray
        return label
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
}

// MARK: - Privates

private extension RegisterResultViewController {
    func addViews() {
        view.addSubviews(
            successmarkImageView,
            thatsItLabel,
            loadingAnimationView
        )
    }
    
    func configureConstraints() {
        successmarkImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(240)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(128)
        }
        
        thatsItLabel.snp.makeConstraints {
            $0.top.equalTo(successmarkImageView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        loadingAnimationView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(96)
            $0.width.height.equalTo(128)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        registerResultToHomepage()
        
        view.backgroundColor = .customBackgroundColor2
    }
    
    func registerResultToHomepage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.pushViewController(TabBarController(), animated: true)
        }
    }
}
