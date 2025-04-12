//
//  ProfileViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import UIKit
import SnapKit

// MARK: - ProfileViewController

class ProfileViewController: UIViewController {

    // MARK: - Properties

    private let userImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = .init(systemName: "camera")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 64
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private lazy var editPhotoButton: UIButton = {
        let button: UIButton = .init()
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .heavy)
        let image = UIImage(systemName: "pencil", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .customButton
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    private let usernameLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "@sburraakm"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var settingsTableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .customBackgroundColor2
        tableView.rowHeight = 100
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        return tableView
    }()
    
    private let viewModel: ProfileViewModel
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Inits
    
    init(viewModel: ProfileViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Objective - C Methods

@objc private extension ProfileViewController {
    
}

// MARK: - Privates

private extension ProfileViewController {
    func addViews() {
        view.addSubviews(
            userImageView,
            editPhotoButton,
            usernameLabel,
            settingsTableView
        )
    }
    
    func configureConstraints() {
        userImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(128)
        }
        
        editPhotoButton.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).inset(40)
            $0.leading.equalTo(userImageView.snp.trailing).inset(36)
            $0.width.height.equalTo(40)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        settingsTableView.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(48)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        view.backgroundColor = .customBackgroundColor2
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as! SettingsCell
        cell.configure(with: viewModel.settingsList[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

#Preview {
    ProfileViewController()
}
