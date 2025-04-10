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
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customOptions
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.numberOfLines = 0
        label.textAlignment = .center
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
    
    func configure(with cell: Category) {
        categoryNameLabel.text = cell.categoryName
        
        guard let urlString = cell.categoryImageURL, let imageURL = URL(string: urlString) else { return }
        categoryImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension CategoryCell {
    func addViews() {
        containerView.addSubview(categoryImageView)
        containerView.addSubview(categoryNameLabel)
        contentView.addSubview(containerView)
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        categoryImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(96)
        }
        
        categoryNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(32)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
