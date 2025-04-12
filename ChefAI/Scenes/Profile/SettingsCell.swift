//
//  SettingsCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 12.04.2025.
//

import UIKit
import SnapKit

// MARK: - SettingsCell

class SettingsCell: UITableViewCell {
    static let identifier = "settingsCell"
    
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .customOptions
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let settingsImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let settingsNameLabel: UILabel = {
        let label: UILabel = .init()
        label.text = ""
        label.textColor = .black
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(systemName: "chevron.right")
        return imageView
    }()
    
    // MARK: - Methods
    
    func configure(with cell: SettingsModel) {
        settingsImageView.image = .init(systemName: cell.image)
        settingsNameLabel.text = cell.name
    }
    
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

private extension SettingsCell {
    func addViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(
            settingsImageView,
            settingsNameLabel,
            arrowImageView
        )
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        settingsImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(32)
        }
        
        settingsNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(16)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        contentView.backgroundColor = .customBackgroundColor2
    }
}
