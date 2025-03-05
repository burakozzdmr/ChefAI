//
//  ViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 5.03.2025.
//

import UIKit
import SnapKit

// MARK: - SplashViewController

class SplashViewController: UIViewController {

    // MARK: - Properties
    
    private let appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .customAppLogo
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let chefLabel: UILabel = {
        let label = UILabel()
        label.text = "ChefAI"
        label.textColor = .customText
        label.font = .systemFont(ofSize: 64, weight: .heavy)
        label.textAlignment = .center
        return label
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
        view.addSubview(chefLabel)
        view.addSubview(loadingIndicatorView)
    }
    
    func configureConstraints() {
        appLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(192)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(256)
        }
        
        chefLabel.snp.makeConstraints { make in
            make.top.equalTo(appLogoImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        loadingIndicatorView.snp.makeConstraints { make in
            make.top.equalTo(chefLabel.snp.bottom).offset(96)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        view.backgroundColor = .customBackground
    }
}
