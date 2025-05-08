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
    
    private lazy var chatTableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .customBackgroundColor2
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(ChatCell.self, forCellReuseIdentifier: ChatCell.identifier)
        return tableView
    }()
    
    private lazy var promptTextField: UnderlineTextField = {
        let textField: UnderlineTextField = .init()
        textField.placeholder = "Ask to Chef"
        textField.borderStyle = .none
        textField.delegate = self
        textField.textColor = .red
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
    
    private let viewModel: ChefViewModel
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - Inits
    
    init(viewModel: ChefViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension ChefViewController {
    func addViews() {
        view.addSubviews(
            bottomStackView,
            dismissButton,
            chatTableView
        )
        bottomStackView.addArrangedSubview(promptTextField)
        bottomStackView.addArrangedSubview(sendButton)
    }
    
    func configureConstraints() {
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        chatTableView.snp.makeConstraints {
            $0.top.equalTo(dismissButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomStackView.snp.top).offset(-8)
        }
        
        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(chatTableView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
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
    }
}

// MARK: - Objective - C Methods

@objc private extension ChefViewController {
    func sendTapped() {
        viewModel.sendMessage(promptText: viewModel.geminiPrompt + (promptTextField.text ?? ""))
        
        promptTextField.text = ""
    }
    
    func dismissTapped() {
        let alert = UIAlertController(title: "UYARI", message: "Sohbeti bitirmek üzeresiniz", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "Evet", style: .default, handler: { _ in
                self.dismiss(animated: true)
            })
        )
        alert.addAction(
            UIAlertAction(title: "İptal", style: .destructive)
        )
        self.present(alert, animated: true)
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
        return .init()
    }
}

// MARK: - UITableViewDelegate

extension ChefViewController: UITableViewDelegate {
    
}

// MARK: - UITextFieldDelegate

extension ChefViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - ChefViewModelProtocol

extension ChefViewController: ChefViewModelProtocol {
    func didUpdateData() {
        UIView.transition(with: chatTableView, duration: 0.25, options: .transitionCrossDissolve) {
            DispatchQueue.main.async {
                self.chatTableView.reloadData()
            }
        }
    }
}
