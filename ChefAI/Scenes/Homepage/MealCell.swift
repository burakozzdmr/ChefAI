//
//  MealCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 9.03.2025.
//

import UIKit
import Kingfisher
import SnapKit

class MealCell: UICollectionViewCell {
    static let identifier = "mealCell"
    
    // MARK: - Properties
    
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
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.numberOfLines = 3
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
    
    func configure(with cellContent: Meal) {
        mealNameLabel.text = cellContent.mealName
        
        guard let urlString = cellContent.mealImageURL, let imageURL = URL(string: urlString) else { return }
        
        mealImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension MealCell {
    func addViews() {
        addSubview(mealImageView)
        addSubview(mealNameLabel)
    }
    
    func configureConstraints() {
        mealImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(96)
        }
        
        mealNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mealImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        clipsToBounds = false
        layer.cornerRadius = 16
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        layer.borderWidth = 1
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.15
        layer.masksToBounds = false
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
