//
//  IngredientCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 11.03.2025.
//

import UIKit
import Kingfisher
import SnapKit

class IngredientCell: UICollectionViewCell {
    static let identifier = "ingredientCell"
    
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customOptions
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let ingredientNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.numberOfLines = 3
        return label
    }()
    
    private let bottomView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with cellContent: Ingredient) {
        ingredientNameLabel.text = cellContent.ingredientName
        
        guard let imageURL = URL(string: "https://www.themealdb.com/images/ingredients/\(cellContent.ingredientName).png") else { return }
        ingredientImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension IngredientCell {
    func addViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(
            ingredientImageView,
            bottomView,
            ingredientNameLabel
        )
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ingredientImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ingredientNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(bottomView)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
