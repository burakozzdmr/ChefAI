//
//  LoadingView.swift
//  ChefAI
//
//  Created by Burak Özdemir on 28.03.2025.
//

import UIKit
import Lottie

// MARK: - LoadingView

class LoadingView: UIView {
    
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        return view
    }()
    
    private let loadingIndicatorView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loadingAnimation")
        animationView.animationSpeed = 1
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension LoadingView {
    func addViews() {
        containerView.addSubview(loadingIndicatorView)
        self.addSubview(containerView)
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(144)
        }
        
        loadingIndicatorView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(containerView)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        self.backgroundColor = .black.withAlphaComponent(0.5)
    }
}
