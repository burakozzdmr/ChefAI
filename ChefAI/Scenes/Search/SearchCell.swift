//
//  SearchCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 5.05.2025.
//

import UIKit
import SnapKit
import Kingfisher

class SearchCell: UITableViewCell {
    static let identifier = "searchCell"

    // MARK: - Properties
    
    private let containerView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .customBackgroundColor2
        return view
    }()
    
    private let mealImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let mealNameLabel: UILabel = {
        let label: UILabel = .init()
        label.text = ""
        label.font = .systemFont(ofSize: 17, weight: .black)
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var crossButton: UIButton = {
        let button: UIButton = .init()
        button.tintColor = .darkGray
        let configuration = UIImage.SymbolConfiguration(pointSize: 21, weight: .heavy)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: configuration), for: .normal)
        button.addTarget(self, action: #selector(crossTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with cell: Meal) {
        mealNameLabel.text = cell.mealName
        
        guard let urlString = cell.mealImageURL, let imageURL = URL(string: urlString) else { return }
        mealImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension SearchCell {
    func addViews() {
        containerView.addSubviews(
            mealImageView,
            mealNameLabel,
            crossButton
        )
        
        addSubview(containerView)
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        mealImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(64)
        }
        
        mealNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(mealImageView.snp.trailing).offset(16)
        }
        
        crossButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        backgroundColor = .customBackgroundColor2
    }
}

// MARK: - Objective-C Methods

@objc private extension SearchCell {
    func crossTapped() {
        // storage service call for selected meals delete process.
    }
}
