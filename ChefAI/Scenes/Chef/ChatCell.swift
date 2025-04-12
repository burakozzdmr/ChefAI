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
    
    private let containerView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .white
        return view
    }()
    
    private let aiImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = .init(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        return imageView
    }()
    
    private let aiMessageLabel: UILabel = {
        let label: UILabel = .init()
        label.text = ""
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let userImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = .init(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        return imageView
    }()
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension ChatCell {
    func addViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(
            aiImageView,
            aiMessageLabel,
            userImageView
        )
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(8)
        }
        
        aiImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
        }
        
        aiMessageLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        userImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(8)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
