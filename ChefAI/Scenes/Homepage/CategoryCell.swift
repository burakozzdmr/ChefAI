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
