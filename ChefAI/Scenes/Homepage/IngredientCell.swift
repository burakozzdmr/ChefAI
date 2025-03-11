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
    
    private let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let ingredientNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .heavy)
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
        addSubview(ingredientImageView)
        addSubview(ingredientNameLabel)
    }
    
    func configureConstraints() {
        ingredientImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(96)
        }
        
        ingredientNameLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 16
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 2
    }
}
