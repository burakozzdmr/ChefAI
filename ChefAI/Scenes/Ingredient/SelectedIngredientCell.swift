//
//  IngredientCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 1.07.2025.
//

import UIKit
import SnapKit
import Kingfisher

class SelectedIngredientCell: UICollectionViewCell {
    static let identifier = "selectedIngredientCell"
    
    private let ingredientImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 32
        return imageView
    }()
    
    private let ingredientNameLabel: UILabel = {
        let label: UILabel = .init()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let bottomView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Publics
    
    func configure(with cell: Ingredient) {
        ingredientNameLabel.text = cell.ingredientName
        guard let imageURL = URL(string: "https://www.themealdb.com/images/ingredients/\(cell.ingredientName).png") else { return }
        ingredientImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension SelectedIngredientCell {
    func configureView() {
        addViews()
        configureConstraints()
    }
    
    func addViews() {
        contentView.addSubviews(
            ingredientImageView,
            ingredientNameLabel,
            bottomView
        )
        bottomView.addSubview(ingredientNameLabel)
    }
    
    func configureConstraints() {
        ingredientImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ingredientNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().offset(16)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
}
