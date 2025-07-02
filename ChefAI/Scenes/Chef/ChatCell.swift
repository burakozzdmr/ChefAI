//
//  ChatCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 11.04.2025.
//

import UIKit
import SnapKit

class ChatCell: UITableViewCell {
    static let identifier = "chatCell"
    static let profilePhotoDidChangeNotification = Notification.Name("ProfilePhotoDidChange")
    private var cachedProfileImage: UIImage?
    
    // MARK: - Properties
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let geminiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .splash
        imageView.tintColor = .white
        imageView.backgroundColor = .customButton
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private var isHaveProfilePicture: Bool = false
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(Self.handleProfilePhotoDidChange), name: Self.profilePhotoDidChangeNotification, object: nil)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods
    
    func configure(with message: String, type: UserChatType) {
        messageLabel.text = message
        
        switch type {
        case .user:
            bubbleView.backgroundColor = .lightGray
            userImageView.isHidden = false
            geminiImageView.isHidden = true
            
            bubbleView.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(8)
                $0.bottom.equalToSuperview().inset(8)
                $0.trailing.equalTo(userImageView.snp.leading).offset(-8)
                $0.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.75)
            }
            
        case .gemini:
            bubbleView.backgroundColor = .customButton
            userImageView.isHidden = true
            geminiImageView.isHidden = false
            
            bubbleView.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(8)
                $0.bottom.equalToSuperview().inset(8)
                $0.leading.equalTo(geminiImageView.snp.trailing).offset(8)
                $0.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.75)
            }
        }
    }
    
    @objc private func handleProfilePhotoDidChange() {
        self.cachedProfileImage = nil
        // Yeni fotoğrafı hemen göstermek için isteğe bağlı:
        if let imageData = StorageManager.shared.loadImageFromDisk(userID: AuthService.fetchUserID()),
           let image = UIImage(data: imageData) {
            self.cachedProfileImage = image
            userImageView.image = image
        }
    }
}

// MARK: - Privates

private extension ChatCell {
    func addViews() {
        contentView.addSubviews(
            userImageView,
            geminiImageView,
            bubbleView
        )
        bubbleView.addSubview(messageLabel)
    }
    
    func configureConstraints() {
        userImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.top.equalToSuperview().offset(8)
            make.width.height.equalTo(32)
        }
        
        geminiImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.width.height.equalTo(32)
        }
        
        bubbleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.75)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        backgroundColor = .clear
        selectionStyle = .none
        
        if let cached = cachedProfileImage {
            userImageView.image = cached
        } else {
            if let imageData = StorageManager.shared.loadImageFromDisk(userID: AuthService.fetchUserID()),
               let image = UIImage(data: imageData) {
                cachedProfileImage = image
                userImageView.image = image
            }
        }
    }
}
