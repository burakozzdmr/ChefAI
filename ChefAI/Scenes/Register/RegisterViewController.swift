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
        imageView.image = .splash
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var usernameTextField: BYUnderlineTextField = {
        let textField = BYUnderlineTextField(
            placeholder: "Full Name",
            alertMessage: "Invalid full name",
            underlineColor: .customButton,
            characters: [],
            textColor: .lightGray,
            leftIcon: "person.text.rectangle.fill"
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
    
    private lazy var confirmPasswordTextField: BYUnderlineSecurityTextField = {
        let textField = BYUnderlineSecurityTextField(
            placeholder: "Confirm Password",
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
    
    private let viewModel: RegisterViewModel
    private let loadingView: LoadingView = .init()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Inits
    
    init(viewModel: RegisterViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension RegisterViewController {
    func addViews() {
        view.addSubviews(
            appLogoImageView,
            usernameTextField,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField,
            registerButton,
            loadingView
        )
    }
    
    func configureConstraints() {
        appLogoImageView.snp.makeConstraints { 
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(64)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(128)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(appLogoImageView.snp.bottom).offset(48)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
        }
        
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
            $0.height.equalTo(64)
        }
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        view.backgroundColor = .customBackgroundColor2
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardGesture)
        
        loadingView.isHidden = true
    }
}

// MARK: - Objective-C Methods

private extension RegisterViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func registerTapped() {
        if usernameTextField.text == ""
            || emailTextField.text == ""
            || passwordTextField.text == ""
            || confirmPasswordTextField.text == "" {
            AlertManager.shared.presentAlert(
                with: "ERROR",
                and: "Please fill in all fields",
                buttons: [
                    UIAlertAction(title: "OK", style: .default)
                ],
                from: self
            )
        } else if passwordTextField.text != confirmPasswordTextField.text {
            AlertManager.shared.presentAlert(with: "WARNING", and: "Passwords do not match!", buttons: [
                UIAlertAction(title: "OK", style: .default)
            ], from: self)
        } else {
            loadingView.isHidden = false
            viewModel.signUp(with: emailTextField.text ?? "", and: passwordTextField.text ?? "") { authError in
                if authError != nil {
                    self.loadingView.isHidden = true
                    AlertManager.shared.presentAlert(
                        with: "ERROR",
                        and: "A user with this credentials already exists",
                        buttons: [
                            UIAlertAction(title: "OK", style: .default)
                        ],
                        from: self
                    )
                    return
                } else {
                    self.viewModel.saveUsername(with: self.usernameTextField.text ?? "")
                    self.navigationController?.pushViewController(RegisterResultViewController(), animated: true)
                    self.loadingView.removeFromSuperview()
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
