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
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customOptions
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .black)
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
    
    func configure(with cell: Meal) {
        mealNameLabel.text = cell.mealName
        
        guard let urlString = cell.mealImageURL, let imageURL = URL(string: urlString) else { return }
        mealImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension MealCell {
    func addViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(mealImageView)
        containerView.addSubview(bottomView)
        bottomView.addSubview(mealNameLabel)
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalTo(contentView).inset(8)
        }
        
        mealImageView.snp.makeConstraints {
            $0.edges.equalTo(containerView)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(containerView)
            $0.height.equalTo(48)
        }
        
        mealNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(bottomView)
            $0.leading.trailing.equalTo(bottomView).inset(8)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
