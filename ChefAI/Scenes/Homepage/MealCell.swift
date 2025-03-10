//
//  MealCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 9.03.2025.
//

import UIKit

class MealCell: UICollectionViewCell {
    static let identifier = "mealCell"
    
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customButton
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        return imageView
    }()
    
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .customBackground
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Publics
    
    func configure(with cellContent: Meal) {
        
    }
}

// MARK: - Privates

private extension MealCell {
    func addViews() {
        containerView.addSubview(mealImageView)
        containerView.addSubview(mealNameLabel)
        addSubview(containerView)
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mealImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(64)
        }
        
        mealNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mealImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
