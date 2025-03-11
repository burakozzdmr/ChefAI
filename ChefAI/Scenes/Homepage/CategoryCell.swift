//
//  CategoryCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 9.03.2025.
//

import UIKit
import Kingfisher
import SnapKit

class CategoryCell: UICollectionViewCell {
    static let identifier = "categoryCell"
    
    // MARK: - Properties
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let categoryNameLabel: UILabel = {
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
    
    func configure(with cellContent: Category) {
        categoryNameLabel.text = cellContent.categoryName
        
        guard let urlString = cellContent.categoryImageURL else { return }
        guard let imageURL = URL(string: urlString) else { return }
        
        categoryImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension CategoryCell {
    func addViews() {
        addSubview(categoryImageView)
        addSubview(categoryNameLabel)
    }
    
    func configureConstraints() {
        categoryImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(96)
        }
        
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryImageView.snp.bottom).offset(8)
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
