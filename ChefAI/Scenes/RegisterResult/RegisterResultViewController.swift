//
//  RegisterResultViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 6.03.2025.
//

import UIKit
import SnapKit

// MARK: - RegisterResultViewController

class RegisterResultViewController: UIViewController {

    // MARK: - Properties
    
    private let successmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .successIcon
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let thatsItLabel: UILabel = {
        let label = UILabel()
        label.text = "That's it!"
        label.font = .systemFont(ofSize: 48, weight: .black)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var backToLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back to Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
        button.tintColor = .white
        button.backgroundColor = .customButton
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(backLoginTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
}

// MARK: - Privates

private extension RegisterResultViewController {
    func addViews() {
        view.addSubview(successmarkImageView)
        view.addSubview(thatsItLabel)
        view.addSubview(backToLoginButton)
    }
    
    func configureConstraints() {
        successmarkImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(240)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(128)
        }
        
        thatsItLabel.snp.makeConstraints { make in
            make.top.equalTo(successmarkImageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
        backToLoginButton.snp.makeConstraints { make in
            make.top.equalTo(thatsItLabel.snp.bottom).offset(96)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(64)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        view.backgroundColor = .customBackgroundColor2
    }
}

// MARK: - Objective-C Methods

private extension RegisterResultViewController {
    @objc func backLoginTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}

#Preview {
    RegisterResultViewController()
}
