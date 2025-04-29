//
//  ChefViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 6.04.2025.
//

import UIKit
import SnapKit

// MARK: - ChefViewController

class ChefViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var dismissButton: UIButton = {
        let button: UIButton = .init()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .heavy)
        let image = UIImage(systemName: "xmark", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .customButton
        button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var chefTableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGreen
        tableView.register(ChatCell.self, forCellReuseIdentifier: ChatCell.identifier)
        return tableView
    }()
    
    private lazy var promptTextField: UnderlineTextField = {
        let textField: UnderlineTextField = .init()
        textField.placeholder = "Type something"
        textField.borderStyle = .none
        textField.delegate = self
        textField.textColor = .lightGray
        textField.returnKeyType = .send
        return textField
    }()
    
    private lazy var sendButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(.init(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .customButton
        button.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 24
        return button
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - Inits
    
    
}

// MARK: - Privates

private extension ChefViewController {
    func addViews() {
        view.addSubviews(
            dismissButton,
            chefTableView,
            bottomStackView
        )
        
        bottomStackView.addArrangedSubview(promptTextField)
        bottomStackView.addArrangedSubview(sendButton)
    }
    
    func configureConstraints() {
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.trailing.equalToSuperview().inset(36)
        }
        
        chefTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(48)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomStackView.snp.top).offset(-16)
        }
        
        bottomStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(360)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        sendButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Objective - C Methods

@objc private extension ChefViewController {
    func sendTapped() {
        
    }
    
    func dismissTapped() {
        dismiss(animated: true)
    }
    
    func dismissKeyboard() {
        promptTextField.endEditing(true)
    }
}

// MARK: - UITableViewDataSource

extension ChefViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ChefViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - UITextFieldDelegate

extension ChefViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
