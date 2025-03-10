//
//  CategoryCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 9.03.2025.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {
    static let identifier = "categoryCell"
    
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
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        return imageView
    }()
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .customBackground
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
        categoryTitleLabel.text = cellContent.categoryName
        
        guard let urlString = cellContent.categoryImageURL else { return }
        guard let imageURL = URL(string: urlString) else { return }
        
        categoryImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension CategoryCell {
    func addViews() {
        containerView.addSubview(categoryImageView)
        containerView.addSubview(categoryTitleLabel)
        addSubview(containerView)
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(64)
        }
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
