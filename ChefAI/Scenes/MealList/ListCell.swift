//
//  ListCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 13.03.2025.
//

import UIKit
import SnapKit
import Kingfisher

class ListCell: UICollectionViewCell {
    static let identifier = "listCell"
    
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customOptions
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16, weight: .black)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with cellContent: Meal) {
        guard let urlString = cellContent.mealImageURL, let imageURL = URL(string: urlString) else { return }
        mealImageView.kf.setImage(with: imageURL)
        
        mealNameLabel.text = cellContent.mealName
    }
}

// MARK: - Privates

private extension ListCell {
    func addViews() {
        containerView.addSubview(mealImageView)
        containerView.addSubview(mealNameLabel)
        self.addSubview(containerView)
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mealImageView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.height.equalTo(128)
        }
        
        mealNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(mealImageView.snp.trailing).offset(64)
            $0.trailing.equalToSuperview().inset(64)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
