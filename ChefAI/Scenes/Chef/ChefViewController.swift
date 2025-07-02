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
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        return tableView
    }()
    
    private lazy var promptTextField: UnderlineTextField = {
        let textField: UnderlineTextField = .init()
        textField.placeholder = "Ask to Chef"
        textField.borderStyle = .none
        textField.delegate = self
        textField.textColor = .white
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
    private var bottomStackViewBottomConstraint: Constraint?
    private let loadingView: LoadingView = .init()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupKeyboardObservers()
    }


    // MARK: - Inits
    
    init(viewModel: ChefViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Privates

private extension ChefViewController {
    func addViews() {
        view.addSubviews(
            bottomStackView,
            dismissButton,
            chatTableView,
            loadingView
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
            bottomStackViewBottomConstraint = $0.bottom.equalTo(view.safeAreaLayoutGuide).constraint
        }
        
        sendButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
        }
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        view.backgroundColor = .customBackgroundColor2
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}

// MARK: - Objective - C Methods

@objc private extension ChefViewController {
    func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.25
        
        UIView.animate(withDuration: duration) {
            self.bottomStackViewBottomConstraint?.update(offset: -keyboardHeight)
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.25
        
        UIView.animate(withDuration: duration) {
            self.bottomStackViewBottomConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
        }
    }
    
    func sendTapped() {
        viewModel.sendMessage(promptText: promptTextField.text ?? "")
        promptTextField.text = ""
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
        return viewModel.chatMessageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
        let chatMessage = viewModel.chatMessageList[indexPath.row]
        cell.configure(with: chatMessage.message, type: chatMessage.type)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ChefViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.chatMessageList.count - 1 {
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
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
        DispatchQueue.main.async {
            UIView.transition(with: self.chatTableView, duration: 0.25, options: .transitionCrossDissolve) {
                self.chatTableView.reloadData()
            }
        }
    }
}
