//
//  RegisterViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 6.03.2025.
//

import UIKit
import BYCustomTextField
import SnapKit

// MARK: - RegisterViewController

class RegisterViewController: UIViewController {

    // MARK: - Properties
    
    private let appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appLogo
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var usernameTextField: BYUnderlineTextField = {
        let textField = BYUnderlineTextField(
            placeholder: "Username",
            alertMessage: "Invalid username",
            underlineColor: .customButton,
            characters: [],
            textColor: .lightGray,
            leftIcon: "person.fill"
        )
        textField.delegate = self
        return textField
    }()
    
    private lazy var emailTextField: BYUnderlineTextField = {
        let textField = BYUnderlineTextField(
            placeholder: "E-Mail",
            alertMessage: "Invalid email",
            underlineColor: .customButton,
            characters: ["@", "."],
            textColor: .lightGray,
            leftIcon: "envelope.fill"
        )
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: BYUnderlineSecurityTextField = {
        let textField = BYUnderlineSecurityTextField(
            placeholder: "Password",
            alertMessage: "Invalid password",
            underlineColor: .customButton,
            minCharacterCount: 6,
            textColor: .lightGray,
            leftIcon: "key.fill"
        )
        textField.delegate = self
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Register", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
        button.backgroundColor = .customButton
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
}
// MARK: - Privates

private extension RegisterViewController {
    func addViews() {
        view.addSubview(appLogoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
    }
    
    func configureConstraints() {
        appLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(64)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(128)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(appLogoImageView.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(64)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(64)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        view.backgroundColor = .customBackgroundColor2
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardGesture)
    }
}

// MARK: - Objective-C Methods

private extension RegisterViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func registerTapped() {
        navigationController?.pushViewController(RegisterResultViewController(), animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

#Preview {
    RegisterViewController()
}
