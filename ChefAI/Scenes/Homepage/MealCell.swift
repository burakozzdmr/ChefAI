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
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .black)
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
    
    func configure(with cell: Meal) {
        mealNameLabel.text = cell.mealName
        
        guard let urlString = cell.mealImageURL, let imageURL = URL(string: urlString) else { return }
        mealImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension MealCell {
    func addViews() {
        containerView.addSubview(mealImageView)
        containerView.addSubview(mealNameLabel)
        contentView.addSubview(containerView)
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mealImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(96)
        }
        
        mealNameLabel.snp.makeConstraints {
            $0.top.equalTo(mealImageView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.bottom.equalToSuperview().inset(4)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
