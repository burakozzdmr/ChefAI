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
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let geminiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "brain.head.profile")
        imageView.tintColor = .white
        imageView.backgroundColor = .customButton
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubviews(
            userImageView,
            geminiImageView,
            bubbleView
        )
        bubbleView.addSubview(messageLabel)
        
        userImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.width.height.equalTo(32)
        }
        
        geminiImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
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
    
    func configure(with message: String, type: UserChatType) {
        messageLabel.text = message
        
        switch type {
        case .user:
            bubbleView.backgroundColor = .lightGray
            userImageView.isHidden = false
            geminiImageView.isHidden = true
            bubbleView.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.bottom.equalToSuperview().offset(-8)
                make.leading.equalTo(userImageView.snp.trailing).offset(8)
                make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.75)
            }
            
        case .gemini:
            bubbleView.backgroundColor = .customButton
            userImageView.isHidden = true
            geminiImageView.isHidden = false
            bubbleView.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.bottom.equalToSuperview().offset(-8)
                make.trailing.equalTo(geminiImageView.snp.leading).offset(-8)
                make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.75)
            }
        }
    }
}
