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
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.numberOfLines = 3
        label.textAlignment = .center
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
    
    func configure(with cell: Category) {
        categoryNameLabel.text = cell.categoryName
        
        guard let urlString = cell.categoryImageURL, let imageURL = URL(string: urlString) else { return }
        categoryImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension CategoryCell {
    func addViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(categoryImageView)
        containerView.addSubview(bottomView)
        bottomView.addSubview(categoryNameLabel)
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalTo(contentView).inset(8)
        }
        
        categoryImageView.snp.makeConstraints {
            $0.edges.equalTo(containerView)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(containerView)
            $0.height.equalTo(48)
        }
        
        categoryNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(bottomView)
            $0.leading.trailing.equalTo(bottomView).inset(8)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
