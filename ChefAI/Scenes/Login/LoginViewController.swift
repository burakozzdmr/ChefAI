//
//  LoginViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 6.03.2025.
//

import UIKit
import BYCustomTextField
import SnapKit

// MARK: - LoginViewController

class LoginViewController: UIViewController {

    // MARK: - Properties
    
    private let appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appLogo
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var emailTextField: BYUnderlineTextField = {
        let textField = BYUnderlineTextField(
            placeholder: "E-Mail",
            alertMessage: "Invalid E-Mail",
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
            alertMessage: "Invalid Password",
            underlineColor: .customButton,
            minCharacterCount: 6,
            textColor: .lightGray,
            leftIcon: "key.fill"
        )
        textField.delegate = self
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
        button.tintColor = .white
        button.backgroundColor = .customButton
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    private let footerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    private let dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private lazy var registerNowLabel: UILabel = {
        let label = UILabel()
        label.text = "Register Now"
        label.textColor = .customButton
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(registerNowTapped))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private let viewModel: LoginViewModel
    private let loadingView: LoadingView = .init()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Inits
    
    init(viewModel: LoginViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension LoginViewController {
    func addViews() {
        view.addSubview(appLogoImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        footerStackView.addArrangedSubview(dontHaveAccountLabel)
        footerStackView.addArrangedSubview(registerNowLabel)
        view.addSubview(footerStackView)
        view.addSubview(loadingView)
    }
    
    func configureConstraints() {
        appLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(64)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(128)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(appLogoImageView.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(96)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(64)
        }
        
        footerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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

private extension LoginViewController {
    @objc func loginTapped() {
        loadingView.isHidden = false
        viewModel.signIn(with: emailTextField.text ?? "", and: passwordTextField.text ?? "") { authError in
            if authError != nil {
                self.loadingView.isHidden = true
                let alertController = UIAlertController(title: "HATA", message: "Kullanıcı adı veya şifre hatalı", preferredStyle: .alert)
                alertController.addAction(
                    UIAlertAction(title: "Tamam", style: .default)
                )
                self.present(alertController, animated: true)
                return
            } else {
                self.navigationController?.pushViewController(TabBarController(), animated: true)
                self.loadingView.removeFromSuperview()
            }
        }
    }
    
    @objc func registerNowTapped() {
        navigationController?.pushViewController(RegisterViewController(viewModel: RegisterViewModel()), animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
