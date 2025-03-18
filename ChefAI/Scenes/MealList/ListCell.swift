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
        view.backgroundColor = .red
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
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
    
    func configure(with cellContent: MealList) {
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
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        mealImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(128)
            make.leading.equalToSuperview().inset(16)
        }
        
        mealNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(mealImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
